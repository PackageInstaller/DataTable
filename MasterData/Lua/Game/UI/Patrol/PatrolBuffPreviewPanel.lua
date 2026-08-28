---
--- Created by Eric.
--- DateTime: 2021/10/20 11:47
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local mazeBagComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MazeBagComponent, Constants.MazeBagEntityId)

------------ import ------------

------------ define ------------
--local MaxCountPerRow = 6
local LoopViewMaxCellCount = 5--循环列表最多显示cell数量

------------ define ------------


---@class PatrolBuffPreviewPanel
---@field CommonTabToggleUp             	UnityEngine.RectTransform
---@field LoopList                      	SuperScrollView.LoopListView2
local PatrolBuffPreviewPanel = Class("PatrolBuffPreviewPanel")
function PatrolBuffPreviewPanel:__init()
    self.cursesList = {}
    self.relicsList = {}
    self.data = {

    }
    self:ResetAnimData()

end

function PatrolBuffPreviewPanel:__delete()
    self.cursesList = nil
    self.relicsList = nil
    self.data = nil
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = nil
    end

    self.controller = nil
end

function PatrolBuffPreviewPanel:ResetAnimData()
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = false
    end
end

function PatrolBuffPreviewPanel:Awake()
    --self.EventUseItem = Events.AddListener(Constants.EventNames.PatrolEventUseItem, Bind(self, self.FreshBaseUI))
    self.CommonTabToggleUpEnv = CfUtils.GetLuaScr(self.CommonTabToggleUp.transform, "Game.Behaviours.CommonTabToggleUp")

    UIEventProxy.Create(self.controller.gameObject).onPointerClick = function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end
end

function PatrolBuffPreviewPanel:InitData()
    self.data = {}
    self.cursesList = mazeBagComponent:GetCursesArr()
    self.relicsList = mazeBagComponent:GetRelicsArr()
    local cursesLength = #self.cursesList
    local relicsLength = #self.relicsList
    local toggleData = {
        [1] = {
            text = localize("增益效应(_num_)",{_num_ = relicsLength}),
            func = function()
                self.data = self.relicsList
                self:OnClickToggleAction()
            end
        },
        [2] = {
            text = localize("减益效应(_num_)",{_num_ = cursesLength}),
            func = function()
                self.data = self.cursesList
                self:OnClickToggleAction()
            end
        },
    }
    self.CommonTabToggleUpEnv:FillToggles(toggleData)
    self.data = self.relicsList--默认是增益面板
    self:OnClickToggleAction()

    --local title1 = {
    --    cellName = "Cell1",
    --    status = 1,
    --    number = string.format("(%d)", relicsLength)
    --}
    --local placeholder = {
    --    cellName = "Cell3",
    --}
    --local title2 = {
    --    cellName = "Cell1",
    --    status = 2,
    --    number = string.format("(%d)", cursesLength)
    --}
    ----圣物标题
    --table.insert(self.data, title1)
    ----圣物内容
    --if relicsLength/MaxCountPerRow > 0 then
    --    for i = 1, relicsLength, MaxCountPerRow do
    --        local relicData ={}
    --        for j = i, i + MaxCountPerRow - 1 do
    --            if not isNull(self.relicsList[j]) then
    --                table.insert(relicData, self.relicsList[j])
    --            end
    --        end
    --        table.insert(self.data, {
    --            cellName = "Cell2",
    --            itemData = relicData
    --        })
    --    end
    --else
    --    table.insert(self.data, {
    --        cellName = "Cell4",
    --        status = 1,
    --    })
    --end
    ----空行占位
    --table.insert(self.data, placeholder)
    ----诅咒标题
    --table.insert(self.data, title2)
    ----诅咒内容
    --if cursesLength/MaxCountPerRow > 0 then
    --    for i = 1, cursesLength, MaxCountPerRow do
    --        local cursesData ={}
    --        for j = i, i + MaxCountPerRow - 1 do
    --            if not isNull(self.cursesList[j]) then
    --                table.insert(cursesData, self.cursesList[j])
    --            end
    --        end
    --        table.insert(self.data, {
    --            cellName = "Cell2",
    --            itemData = cursesData
    --        })
    --    end
    --else
    --    table.insert(self.data, {
    --        cellName = "Cell4",
    --        status = 1,
    --    })
    --end
end

function PatrolBuffPreviewPanel:FreshBaseUI(data)
    self:InitData()
    --local cursesLength = #self.cursesList
    --local relicsLength = #self.relicsList
    --self.TextNumberCurses.text = string.format("(%d)", cursesLength)
    --self.TextNumberRelics.text = string.format("(%d)", relicsLength)
    --KTool.SetActive(self.NoneStatusCurses, cursesLength <= 0)
    --KTool.SetActive(self.NoneStatusRelics, relicsLength <= 0)
    --KTool.SetActive(self.IconScrollCurses.transform, not (cursesLength <= 0))
    --KTool.SetActive(self.IconScrollRelics.transform, not (relicsLength <= 0))

    --if relicsLength > 0 then
    --    if not self.IconScrollRelics.IsListViewInit then
    --        self.IconScrollRelics:InitGridView(relicsLength, Bind(self, self.OnGetItemByIndexRelics))
    --    else
    --        GameUtils.ReloadData(self.IconScrollRelics, relicsLength)
    --    end
    --end
end

function PatrolBuffPreviewPanel:OnClickToggleAction()
    local isNull = table.count(self.data) == 0
    KTool.SetActive(self.LoopList.transform, not isNull)
    if not isNull then
        if not self.LoopList.IsListViewInit then
            self.LoopList:InitListView(#self.data, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(self.LoopList, #self.data)
        end
    end
end



function PatrolBuffPreviewPanel:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, 'Game.UI.Patrol.PatrolBuffPreviewNode')
    if nodeEnv then
        local luaIndex = index + 1
        --@region 刚进入列表时播放延时出现动画
        if not isNull(self["isAnimated"..luaIndex]) then
            if not self["isAnimated"..luaIndex] then
                self["isAnimated"..luaIndex] = true
                CfUtils.PlayDelayShowAnimate(cell.transform:Find("AnimRoot"), luaIndex)
            else
                CfUtils.PlayDelayShowAnimate(cell.transform:Find("AnimRoot"), 0)
            end
        else
            CfUtils.PlayDelayShowAnimate(cell.transform:Find("AnimRoot"), 0)
        end
        --@endregion
        local data = self.data[luaIndex]
        nodeEnv:FreshBaseUI(data)
    end
    return cell
    --if index < 0 then
    --    return nil
    --end
    --local luaIndex = index + 1
    --local data = self.data[luaIndex]
    --local cell = listView:NewListViewItem(data.cellName)
    --if data.cellName == "Cell1" then
    --    local title = cell.transform:Find("ImgBgTitle/TextTitle")
    --    local text = cell.transform:Find("ImgBgTitle/TextNumber")
    --    CfUtils.SetUISwitchText(title, data.status)
    --    CfUtils.FillText(text, data.number)
    --elseif data.cellName == "Cell2" then
    --    local goCount = #data.itemData
    --    if goCount < MaxCountPerRow then
    --        for i = goCount + 1, MaxCountPerRow do --复用时隐藏多出来的
    --            KTool.SetActive(cell.transform:Find("GoodNode"..i), false)
    --        end
    --    end
    --    local itemData = data.itemData
    --    for i = 1, goCount do
    --        local itemCell = cell.transform:Find("GoodNode"..i)
    --        local nodeEnv = CfUtils.GetLuaScr(itemCell, 'Game.Behaviours.GoodNodeMB')
    --        if nodeEnv then
    --            nodeEnv:SetClickButtonAction(function()
    --                --if data.num > 0 then
    --                local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(itemData[i].id, Constants.IDArea.Maze)
    --                if isTable(vo) then
    --                    GameUtils.ShowCommonTipsBoard(itemCell, vo.name, vo.desc, vo.quality, vo.id)
    --                end
    --                --end
    --            end)
    --            nodeEnv:Reload({ goodsId = itemData[i].id,
    --                             isShowNo = false,
    --                             idAreaType = Constants.IDArea.Maze
    --
    --            })
    --        end
    --        KTool.SetActive(itemCell, true)
    --    end
    --elseif data.cellName == "Cell3" then
    --
    --elseif data.cellName == "Cell4" then
    --    local text = cell.transform:Find("NoneStatus/Text")
    --    CfUtils.SetUISwitchText(text, data.status)
    --end
    --KTool.SetActive(cell, true)
    --return cell
end

function PatrolBuffPreviewPanel:OnGetItemByIndexCurses(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("GoodNode")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, 'Game.Behaviours.GoodNodeMB')
    if nodeEnv then
        local luaIndex = index + 1
        local data = self.cursesList[luaIndex]
        nodeEnv:SetClickButtonAction(function()
            --if data.num > 0 then
                local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.id, Constants.IDArea.Maze)
                -- print("------>>"..data.id)
                print(table.dump(vo))
                if isTable(vo) then
                    GameUtils.ShowCommonTipsBoard(cell, vo.name, vo.desc, vo.quality, vo.id)
                end
            --end
        end)
        nodeEnv:Reload({ goodsId = data.id,
                         isShowNo = false,
                         idAreaType = Constants.IDArea.Maze

        })
    end
    return cell
end

function PatrolBuffPreviewPanel:OnGetItemByIndexRelics(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("GoodNode")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, 'Game.Behaviours.GoodNodeMB')
    if nodeEnv then
        local luaIndex = index + 1
        local data = self.relicsList[luaIndex]
        nodeEnv:SetClickButtonAction(function()
            --if data.num > 0 then
                local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.id, Constants.IDArea.Maze)
                if isTable(vo) then
                    GameUtils.ShowCommonTipsBoard(cell, vo.name, vo.desc, vo.quality, vo.id)
                end
            --end
        end)
        nodeEnv:Reload({ goodsId = data.id,
                         isShowNo = false,
                         idAreaType = Constants.IDArea.Maze
        })
    end
    return cell
end

function PatrolBuffPreviewPanel:OnDestroy()
    --Events.RemoveListener(Constants.EventNames.PatrolEventUseItem, self.EventUseItem)
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolBuffPreviewPanel