---
--- Created by Eric.
--- DateTime: 2022/11/21 16:44
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require 'XLua.cs_coroutine'
local ResourceModule = CS.Engine.Modules.ResourceModule
local Animator = CS.UnityEngine.Animator
local GameObject          = CS.UnityEngine.GameObject
local Yielders = CS.Engine.Lib.Yielders
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local sceneManagement     = SceneManagement:GetInstance()

------------ import ------------

------------ define ------------
local OpenType --定义在对应comp中
--= {
--    Resident = 1,--常驻
--    Activity = 2,--活动
--}
------------ define ------------



--- from: Assets/BundleResources/Prefabs/MainInteraction/MainClothChangePanel.prefab
---@class MainRoleClothesDialog
---@field Env                            MainRoleClothesDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnBuy                        	UnityEngine.RectTransform
---@field FontStyleWithGoodIconButton   	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field ColorCell                     	UnityEngine.RectTransform
---@field ColorGroup                    	UnityEngine.RectTransform
---@field TxtDesc                       	UnityEngine.RectTransform
---@field TxtTitle1                     	UnityEngine.RectTransform
---@field TxtTitle                      	UnityEngine.RectTransform
---@field ClothScrollView               	SuperScrollView.LoopGridView
local MainRoleClothesDialog = Class("MainRoleClothesDialog")
function MainRoleClothesDialog:__init()
    self.ids = {}
    self.data = {}
    self.openType = nil
    self.selectLuaIndex = 1
    self.selectIndexColor = 0
    self.colorGoMap = {}
    self.colorData = {}
end

function MainRoleClothesDialog:__delete()
    self.ids = nil
    self.data = nil
    self.openType = nil
    self.selectLuaIndex = nil
    self.selectIndexColor = nil
    self.colorGoMap = nil
    self.colorData = nil

    self.controller = nil
end

function MainRoleClothesDialog:Awake()
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))
    Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
    Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })

    --self:LoadScene()
end

function MainRoleClothesDialog:PlotPlaying(isPlotPlaying)
    self.controller.gameObject.transform.localPosition = isPlotPlaying and Vector3(9999, 9999, 9999) or Vector3(0, 0, 0)
end

function MainRoleClothesDialog:OnFocus(focus)
end

function MainRoleClothesDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)
        OpenType = comp:GetOpenType()
        self.ids = self.controller.Argument.parameters.ids
        self.openType = self.controller.Argument.parameters.openType
        self:InitData()
        --self:FreshBaseUI()
        local isLoadSuccess = false
        local time = GameUtils.ShowBlackOverlay(nil, function()
            while not isLoadSuccess do
                coroutine.yield(Yielders.EndOfFrame)
            end
        end)
        coroutine.yield(WaitForSeconds(time))
        coroutine.yield(self:LoadScene())
        coroutine.yield(self:FreshBaseUI())
        isLoadSuccess = true
    end))
    return coWait
end

function MainRoleClothesDialog:InitData()
    self.data = {}
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)
    for i, v in pairs(self.ids) do
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting2846, "RoleClothesDisplayVo", v)
        if self.openType == OpenType.Resident then
            if vo.show == 1 then
                vo["isShowRoleHead"] = false
                table.insert(self.data, vo)
            else
                if comp:IsUnlockClothByDisplayId(v) then
                    vo["isShowRoleHead"] = false
                    table.insert(self.data, vo)
                end
            end
        else
            vo["isShowRoleHead"] = true
            table.insert(self.data, vo)
        end
    end
    self:SetDefaultSelectIndexCloth()
    self:SetDefaultSelectIndexColor()
end


--function MainRoleClothesDialog:SetBtnAction()
--    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
--    SetButtonAction(self.BtnTask.gameObject, function()
--        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
--        local isEnd = comp:IsEnd()
--        if isEnd then
--            GameUtils.Toast(localize("入口已关闭，未领取的剧情奖励将发至邮箱"))
--            return
--        end
--        UIModule.OpenDialog({ id = Constants.UITypeIds.SnowFestivalScoreTaskDialog, parameters = {
--            --cb = function (status)
--            --end
--        }},
--
--                {
--                    {id = Constants.UITypeIds.MainRoleClothesDialog}
--                })
--    end)
--end

function MainRoleClothesDialog:SetDefaultSelectIndexCloth()
    self.selectLuaIndex = 1
end

function MainRoleClothesDialog:SetDefaultSelectIndexColor()
    self.selectIndexColor = 0
end

function MainRoleClothesDialog:FreshBaseUI()
    if not self.ClothScrollView.IsListViewInit then
        self.ClothScrollView:InitGridView(#self.data, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ClothScrollView, #self.data)
    end
    self:OnClickCloth()
end

function MainRoleClothesDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.RoleClothes.MainRoleClothesDialogClothNode")
    if nodeEnv then
        local data = self.data[luaIndex]
        local isSelected = luaIndex == self.selectLuaIndex
        nodeEnv:FreshBaseUI(data)
        nodeEnv:FreshSelectStatus(isSelected)
        nodeEnv:SetBtnCallBack(function()
            if luaIndex ~= self.selectLuaIndex then
                self:SetDefaultSelectIndexColor()
                --屏蔽掉重复点击当前选择的toggle
                nodeEnv:FreshSelectStatus(true)
                local preNodeGo = self.ClothScrollView:GetShownItemByItemIndex(self.selectLuaIndex - 1)
                if preNodeGo then
                    local preNodeEnv = CfUtils.GetLuaScr(preNodeGo.gameObject, "Game.UI.RoleClothes.MainRoleClothesDialogClothNode")
                    preNodeEnv:FreshSelectStatus(false)
                end
                self.selectLuaIndex = luaIndex
                self:OnClickCloth()
            end
        end)
    end
    return cell
end

function MainRoleClothesDialog:OnClickCloth()
    print("----->>OnClickCloth")
    self:FreshColorGroup()
    self:SetClothModel()
end

---@param data table RoleClothesColorVo 颜色数据
function MainRoleClothesDialog:FreshColorInfo(data)
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)

    --region 刷新描述
    local goodsVo = GoodsConfMgr:GetGoodsVoById(data.id)
    CfUtils.FillText(self.TxtTitle, goodsVo.name)
    CfUtils.FillText(self.TxtTitle1, goodsVo.desc)
    CfUtils.FillText(self.TxtDesc, goodsVo.description)
    --endregion
    local isUnlock = comp:IsUnlockClothByGoodsId(data.id)
    local isWear = comp:IsRoleWearTargetClothByGoodsId(data.roleId, data.id)
    local hasConsume = not string.isEmpty(data.goodsConsum)
    local isShowBuyBtn = (not isUnlock) and hasConsume
    local isShowWear = isUnlock and (not isWear)
    local isShowNotGet = (not isUnlock) and (not hasConsume)
    KTool.SetActive(self.FontStyleButton, not isShowBuyBtn)
    KTool.SetActive(self.FontStyleWithGoodIconButton, isShowBuyBtn)
    if isShowBuyBtn then
        CfUtils.FillFontStyleWithGoodIconButtonNode(self.FontStyleWithGoodIconButton, data.goodsConsum, data.goodsConsumNum)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonBuyItemDialog, parameters = {
            goodsId        = data.id,
            consumeGoodsId = data.goodsConsum,
            consumeNum     = data.goodsConsumNum,
            isPayMoney     = false,
            maxBuyNum      =  1,
            buyCb          = function() self:ConfirmPurchase(data) end,
            rewards        = {goodsId = data.id ,num = 1},
        }})
    else
        if isShowWear then
            self.FontStyleButton:GetComponent("FontStyleButton"):ResetFontStyle("B3", '穿戴')
            SetButtonAction(self.FontStyleButton, function()
                self:ChangeCloth(data)
            end)
        elseif isShowNotGet then
            self.FontStyleButton:GetComponent("FontStyleButton"):ResetFontStyle("B17", '未获得')
        elseif isWear then
            self.FontStyleButton:GetComponent("FontStyleButton"):ResetFontStyle("B5", '已穿戴')
        end
    end
    

end

function MainRoleClothesDialog:ConfirmPurchase(data)
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)
    comp:ReqBuyRoleCloth(data.roleId, data.id, function()
        GoodsUtils.ConsumeGoods({
            {
                goodsId = data.goodsConsum,
                num = data.goodsConsumNum
            }
        }, true)
        self:FreshColorGroup()
        self.ClothScrollView:RefreshAllShownItem()
    end)
end

function MainRoleClothesDialog:ChangeCloth(data)
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)
    local _isUnlock = comp:IsUnlockClothByGoodsId(data.id)
    local _isWear = comp:IsRoleWearTargetClothByGoodsId(data.roleId, data.id)
    local _isShowWear = _isUnlock and (not _isWear)
    if _isShowWear then
        comp:ReqChangeRoleCloth(data.roleId, data.id, function()
            self:FreshColorGroup()
            self.ClothScrollView:RefreshAllShownItem()
        end)
    end
end

function MainRoleClothesDialog:FreshColorGroup()
    for i = 0, 2 do
        print("self.data======>>"..table.dump(self.data))
        local colorVo = CfUtils.GetCfVo(AutoIds.IdSetting2847, "RoleClothesColorVo", self.data[self.selectLuaIndex].id..i)
        local go
        go = self.colorGoMap[tostring(i)]
        if colorVo then
            colorVo["roleId"] = self.data[self.selectLuaIndex].roleId
            self.colorData[tostring(i)] = colorVo
        else
            if go then
                KTool.SetActive(go, false)
            end
            goto continue
        end
        print("self.colorData======>>"..table.dump(self.colorData))
        if not go then
            go = CfUtils.InstantiateGo(self.ColorCell, self.ColorGroup.gameObject)
            go.name = "ColorNode"..i
            self.colorGoMap[tostring(i)] = go.gameObject
        end
        local nodeEnv = CfUtils.GetLuaScr(go, "Game.UI.RoleClothes.MainRoleClothesDialogColorNode")
        local data = self.colorData[tostring(i)]
        local isSelected = i == self.selectIndexColor
        if isSelected then
            self:FreshColorInfo(data)
        end
        nodeEnv:FreshBaseUI(data)
        nodeEnv:FreshSelectStatus(isSelected)
        nodeEnv:SetBtnCallBack(function()
            if i ~= self.selectIndexColor then
                --屏蔽掉重复点击当前选择的toggle
                nodeEnv:FreshSelectStatus(true)
                self:FreshColorInfo(data)

                local preNodeGo = self.colorGoMap[tostring(self.selectIndexColor)]
                if preNodeGo then
                    local preNodeEnv = CfUtils.GetLuaScr(preNodeGo.gameObject, "Game.UI.RoleClothes.MainRoleClothesDialogColorNode")
                    preNodeEnv:FreshSelectStatus(false)
                end
                self.selectIndexColor = i
                self:SetClothModel()
            end
        end)
        KTool.SetActive(go, true)
        :: continue ::

    end
end

function MainRoleClothesDialog:SetClothModel()
    if self.modelGo then
        CS.UnityEngine.GameObject.Destroy(self.modelGo)
    end
    local vo = self.colorData[tostring(self.selectIndexColor)]--CfUtils.GetCfVo(AutoIds.IdSetting2847, "RoleClothesColorVo", id)
    if vo then
        local path = vo.prefab
        local loader = ResourceModule.LoadBundleAsync(path, nil, true)
        while not loader.IsSuccess do
            cs_coroutine.yield_return()
        end
        if not loader.IsError then
            local go = loader:Instantiate(self.sceneGo.transform)
            go.name = vo.id
            self.modelGo = go
            go.transform.localPosition = Vector3.New(vo.position[1], vo.position[2], vo.position[3])
        end
        loader:Release()
        loader = nil
        local ani = KTool.GetOrAddComponent(self.modelGo.gameObject, typeof(Animator))
        if ani then
            local pathAnim = vo.animator
            local loaderAnim = ResourceModule.LoadBundleSync(pathAnim, nil, true)

            --local animCtrl
            if loaderAnim.IsSuccess then
                --animCtrl = GameObject.Instantiate()
                --if animCtrl then
                    ani.runtimeAnimatorController = loaderAnim.ResultObject
                --end
            end
            loaderAnim:Release()
            loaderAnim = nil
        end
        self:SetCatTouchAndDrag()
    end
end

function MainRoleClothesDialog:SetCatTouchAndDrag()
    --旋转
    --local dragComp = self.EmptyBg.gameObject:EnsureComponent(typeof(PinchAndDragInputModule))
    self.EmptyBg.onSingleFingerDrag:RemoveAllListeners()
    self.EmptyBg.onSingleFingerDrag:AddListener(function(delta)
        if isNull(delta) then
            return
        end
        local y = delta.y
        local x = delta.x
        local absX = math.abs(x)
        local absY = math.abs(y)
        if math.abs(absX - absY) <= 2 then
            return
        end
        if math.abs(y) <= math.abs(x) then
            local direction = x < 0 and 1 or -1
            local eulerAngles = Vector3.New(0, 1, 0)
            eulerAngles.y = eulerAngles.y * direction * math.abs(x)
            self.modelGo.transform:Rotate(eulerAngles)
        end
    end)
end

function MainRoleClothesDialog:LoadScene()
    if not isNull(self.sceneGo) then
        printInfo("sceneGo not null")
        return
    end
    local co = cs_coroutine.start(function ()
        xTry(function()
            local loader = ResourceModule.LoadBundleAsync("Arts/Prefab_item/springfestival_scene_2023_prefab/staffRoom.prefab", nil, true)
            while not loader.IsSuccess do
                cs_coroutine.yield_return()
            end
            if not loader.IsError then
                local go = loader:Instantiate()
                CS.UnityEngine.GameObject.DontDestroyOnLoad(go)
                go.name = "RoleClothesScene"
                self.sceneGo = go
            end
            loader:Release()
            loader = nil
        end
        )
    end)
    return co
end


function MainRoleClothesDialog:RestoreSceneState()
    local scenesState = self._oldShowLoadedScenesState
    if scenesState then
        for identifier, enable in pairs(scenesState) do
            sceneManagement:SetActive(identifier, enable)
        end
        self._oldShowLoadedScenesState = nil
    end
end

function MainRoleClothesDialog:DisposeLoadRes()
    if not isNull(self.sceneGo)  then
        CS.UnityEngine.GameObject.Destroy(self.sceneGo)
    end
end

function MainRoleClothesDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:DisposeLoadRes()
        self:RestoreSceneState()
        --Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = true })
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return MainRoleClothesDialog