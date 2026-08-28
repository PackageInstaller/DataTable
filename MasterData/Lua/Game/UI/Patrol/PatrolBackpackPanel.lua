---
--- Created by Eric.
--- DateTime: 2021/10/20 11:47
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local mazeBagComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MazeBagComponent, Constants.MazeBagEntityId)
local UIModule = CS.Engine.UI.UIModule
local MazeMgr = import('Game.Maze.MazeMgr'):GetInstance()

------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolBackpackPanel
---@field heroView                      	UnityEngine.RectTransform
---@field Roles                         	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field TextDesc                      	UnityEngine.UI.Text
---@field ImgBgName                     	Game.Native.Common.UISwitchImage
---@field ImgIcon                       	Engine.UI.ImageAlterable
---@field TextNumber                    	TMPro.TextMeshProUGUI
---@field TextName                      	UnityEngine.UI.Text
---@field RightGroup                    	UnityEngine.RectTransform
---@field IconScroll                    	SuperScrollView.LoopGridView
---@field Props                         	UnityEngine.RectTransform
---@field NotEmpty                      	UnityEngine.RectTransform
---@field Empty                         	UnityEngine.RectTransform
local PatrolBackpackPanel = Class("PatrolBackpackPanel")
function PatrolBackpackPanel:__init()
    self.itemList = {}
    --self.teamPanelEnv = nil
    self.selectIndex = 1 --luaIndex

end

function PatrolBackpackPanel:__delete()
    self.itemList = nil
    --self.teamPanelEnv = nil
    self.selectIndex = nil

    self.controller = nil
end

function PatrolBackpackPanel:Awake()

    --if isNull(self.teamPanelEnv) then
    --    self.teamPanelEnv = CfUtils.GetLuaScr(self.heroView, "Game.UI.Patrol.PatrolTeamPanel")
    --end
end

function PatrolBackpackPanel:FreshBaseUI()

    --self.IconScroll = self.IconScroll.transform.gameObject:GetComponent(typeof(CS.SuperScrollView.LoopGridView))
    --print("=================")
    self.itemList = mazeBagComponent:GetItemArr()
    --self.itemList = {
    --    {
    --        id = 1001,
    --        num = 1,
    --        idAreaType = Constants.IDArea.Maze,
    --    },
    --    {
    --        id = 1002,
    --        num = 1,
    --        idAreaType = Constants.IDArea.Maze,
    --    },
    --}
    --print("itemList---->>"..table.dump(self.itemList))
    local itemListLength = #self.itemList
    local isEmpty = itemListLength <= 0
    KTool.SetActive(self.Empty, isEmpty)
    KTool.SetActive(self.NotEmpty, not isEmpty)
    if not isEmpty then
        --KTool.SetActive(self.Roles, false)
        self.selectIndex = 1
        if not self.IconScroll.IsListViewInit then
            self.IconScroll:InitGridView(itemListLength, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(self.IconScroll, itemListLength)
        end
    end
end

function PatrolBackpackPanel:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("GoodNode")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, 'Game.Behaviours.GoodNodeMB')
    if nodeEnv then
        cell.gameObject:GetComponent(typeof(CS.Game.Native.Common.ReverseScale)):ResetScale()
        local luaIndex = index + 1
        local data = self.itemList[luaIndex]
        local isSelected = self.selectIndex == luaIndex
        nodeEnv:SetCheckState(isSelected)
        if isSelected then
            self:FreshItemDetails(data)
        end
        nodeEnv:SetClickButtonAction(function()
            if luaIndex ~= self.selectIndex then
                nodeEnv:SetCheckState(true)
                local preHeadNodeGo = self.IconScroll:GetShownItemByItemIndex(self.selectIndex - 1)
                if preHeadNodeGo then
                    local preNodeEnv = CfUtils.GetLuaScr(preHeadNodeGo.gameObject, 'Game.Behaviours.GoodNodeMB')
                    --local preHeadNode = GetLuaBehaviour(preHeadNodeGo.gameObject, EnemyHeadNodePath)
                    preNodeEnv:SetCheckState(false)
                end
                self.selectIndex = luaIndex
                self:FreshItemDetails(data)
            end
        end)
        nodeEnv:Reload({
            goodsId = data.id,
            isShowNo = false,
            idAreaType = Constants.IDArea.Maze
        })
    end
    return cell
end

function PatrolBackpackPanel:FreshItemDetails(data)
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.id, Constants.IDArea.Maze)
    self.TextName.text = vo.name
    self.TextNumber.text = string.format("x%d", data.num)
    self.ImgIcon:LoadSprite(vo.photoPath)
    self.ImgBgName.Status = vo.quality
    self.TextDesc.text = vo.desc
    SetButtonAction(self.FontStyleButton, function ()--目标类型(1.指定 2.全体 3.随机)
        if vo.targetType == Constants.MazeItemTargetType.Appoint then
            --KTool.SetActive(self.Roles.transform, true)
            UIModule.OpenDialog({ id = Constants.UITypeIds.PatrolChooseRolePopup, parameters = {id = data.id}})

            --self.teamPanelEnv:FreshBaseUI({
            --    useItemId = data.id
            --})
        else
            if vo.effectType == Constants.GoodsEffectType.MazeReborn then
                local mazeTeamComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MazeTeamComponent, Constants.MazeTeamEntityId)
                if not mazeTeamComp:CanUseRebornGoods() then
                    GameUtils.Toast(localize("暂无武装需要复活"))
                    return
                end
            --elseif vo.effectType == Constants.GoodsEffectType.MazeCure then
            --    local mazeTeamComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MazeTeamComponent, Constants.MazeTeamEntityId)
            --    if not mazeTeamComp:CanUseCureGoods() then
            --        GameUtils.Toast(localize("暂无武装需要恢复生命"))
            --        return
            --    end
            elseif vo.effectType == Constants.GoodsEffectType.MazeDisperseCurses then
                if not (#mazeBagComponent:GetCursesArr() >= 1) then
                    GameUtils.Toast(localize("暂无负面效果需要清除"))
                    return
                end
            end
            if vo.targetType == Constants.MazeItemTargetType.All then
                GameUtils.SecondConfirm(localize("是否对全体角色使用该道具？"), function()
                    MazeMgr:MazeUseGoods(data.id)
                    GameUtils.Toast(localize("已对全体使用道具"))
                end, nil, vo.desc)
            elseif vo.targetType == Constants.MazeItemTargetType.Random then
                GameUtils.SecondConfirm(localize("是否使用该道具？"), function()
                    MazeMgr:MazeUseGoods(data.id)
                    GameUtils.Toast(localize("已使用道具"))
                end, nil, vo.desc)
            end
        end

    end)
end

function PatrolBackpackPanel:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolBackpackPanel