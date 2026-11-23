







require("Balatro/ViewModel/BalatroChangeForeverGroup")
require("Balatro/ViewModel/BalatroBrandShowUI")
BalatroChangeForeverPopup = {}

BalatroChangeForeverPopup.ChangeForverType = {
    Init = 1,

Change = 2
}

local this = {

    tempChooseBalatro = {},
    tempChooseCount = 0,
    otherBrandParentData = nil
}

local objs = {
    prefabItem = {path = "template/CardItem", type = BalatroUtil.GameObject},
    prefabGroup = {path = "template/Group", type = BalatroUtil.GameObject},
    brandPreviewPrefab = {path = "template/BrandShowItem", type = BalatroUtil.GameObject},
    maskBtn = {path = "root/Mask", type = BalatroUtil.Button},
    titleText = {path = "root/Middle/Group/TitleText", type = BalatroUtil.Text},
    chooseCountText = {path = "root/Middle/Group/ChooseCountBG/ChooseCount", type = BalatroUtil.Text},
    brandPreview = {path = "root/Middle/Group/OtherBrandGroup", type = BalatroUtil.GameObject},
    scrollViewComp = {path = "root/Middle/Group/ScrollView", type = BalatroUtil.ScrollRect},
    scrollContent = {path = "root/Middle/Group/ScrollView/Viewport/Content", type = BalatroUtil.GameObject},
    scrollViewObj = {path = "root/Middle/Group/ScrollView", type = BalatroUtil.GameObject},
    backBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button},
    confirmBtn = {path = "root/Middle/ConfirmBtn", type = BalatroUtil.Button},
    tipsTop = {path = "root/Middle/TipsTop", type = BalatroUtil.GameObject},
    tipsBottom = {path = "root/Middle/TipsBottom", type = BalatroUtil.GameObject}
}

this.ScreenAdapter = function()
    this.scrollWidth = 848
end

this.before_awake = function()
    this.scrollView = UIScrollView.New(this.scrollViewObj)
    this.tipsTopData = BrandBagTips.New(this.tipsTop)
    this.tipsBottomData = BrandBagTips.New(this.tipsBottom)
    this.otherBrandParentData = BalatroBrandShowUI.New(this.brandPreview, this.brandPreviewPrefab, false)
end

this.before_active = function()
    this.CloseBrandInfoTips()
    if this.InternalParam.type == BalatroChangeForeverPopup.ChangeForverType.Init then
        this.titleText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20010")
    else
        this.titleText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20011")
    end
    this.otherBrandParentData:InitItem()
    this.tempChooseCount = 0
    this.tempChooseBalatro = {}
    this.RefreshScroll()
end

this.RefreshScroll = function()
    this.scrollView:Clear()
    local scrollDatas = {}
    this.datas = BalatroDataMgr.GetOwnerBaltatroBrand()
    local datasLen = #this.datas
    local rowMaxCount = 5
    local rows = 0
    if datasLen % rowMaxCount == 0 then
        rows = math.floor(datasLen / rowMaxCount)
    else
        rows = math.floor(datasLen / rowMaxCount) + 1
    end
    local groupWidth, groupHight = 855, 160
    for i = 1, rows do
        local groupData = {}
        groupData.item = this.prefabItem
        groupData.list = {}
        groupData.itemCount = rowMaxCount
        groupData.index = i
        groupData.parentScroll = this.scrollViewComp
        groupData.longTapCallback = this.OnLongClickItem
        local lastPos = (i - 1) * rowMaxCount
        for j = 1, rowMaxCount do
            local tempDatas = this.datas[lastPos + j]
            if tempDatas ~= nil then
                table.insert(groupData.list, tempDatas)
                tempDatas:SetTempSelected(false)
            end
        end
        local scrollData = UIScrollData.GetData(this.prefabGroup, "BalatroChangeForeverGroup", groupWidth, groupHight, groupData)
        table.insert(scrollDatas, scrollData)
    end
    local tempTbl = BalatroDataMgr.GetUsingBalatros()
    for key, value in pairs(tempTbl) do
        this.tempChooseBalatro[key] = {selected = true, balatroData = value}
        this.tempChooseCount = this.tempChooseCount + 1
        value:SetTempSelected(true)
    end
    this.scrollView:SetParams(this.scrollWidth, 520)
    this.scrollView:SetData(scrollDatas, true)
    this.RefreshChooseCount()
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroChangeForeverPopup)
    if this.InternalParam.type == BalatroChangeForeverPopup.ChangeForverType.Init then
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroReplay)
    else
        this.tempChooseBalatro = {}
        this.tempChooseCount = 0
        this.CheckIsChange()
        for key, value in pairs(this.deleteTbl) do
            value:SetTempSelected(true)
            local data = {
                selected = true,
                balatroData = value,
                callback = nil
            }
            LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, data)
        end
        for key, value in pairs(this.addTbl) do
            value:SetTempSelected(false)
            local data = {
                selected = false,
                balatroData = value,
                callback = nil
            }
            LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, data)
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroInitShowBalatroItem)
        this.ClosePanelCallback(true)
    end
end

this.OnClickConfirm = function()
    local curUsingBalatroNum, isChange = this.CheckIsChange()
    if curUsingBalatroNum == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20024")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.InternalParam.type == BalatroChangeForeverPopup.ChangeForverType.Change and isChange == false then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20025")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    elseif this.InternalParam.type == BalatroChangeForeverPopup.ChangeForverType.Init then
        local sceneData = BalatroStepMgr.GetGlobalSceneEffect()
        sceneData:SetDirty()
        BalatroUtil.PlaySound(5)
    end
    if curUsingBalatroNum < BalatroConstVal.MaxBalatroBrandCount then
        local data = {
            leftStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20006"),
            rightStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20012"),
            content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20013"),
            callBackConfirm = this.OnConfirmCallback
        }
        LuaMgr.ShowLuaPanel(UIName.BalatroMsgboxPopUp, data)
    else
        this.OnConfirmCallback()
    end
end

this.ParseParam = function(data)
    this.InternalParam = data
end

this.OnConfirmCallback = function()
    for _, value in pairs(this.deleteTbl) do
        BalatroDataMgr.SelectBrandGroup(value, false)
    end
    for _, value in pairs(this.addTbl) do
        BalatroDataMgr.SelectBrandGroup(value, true)
    end
    this.deleteTbl = {}
    this.addTbl = {}
    LuaMgr.HidePanel(UIName.BalatroChangeForeverPopup)
    this.ClosePanelCallback()
end

this.ClosePanelCallback = function(isCancel)
    if not this.InternalParam then
        LuaDebug.error("BalatroBrandTypeUpgradePopup.ClosePanelCallback 外部传入参数不存在")
        return
    end
    local data = {}
    data.isCancel = isCancel
    data.operateType = this.InternalParam.operateType
    if this.InternalParam.callback then
        this.InternalParam.callback(data)
    end
end

this.CheckIsChange = function()
    local curUsingBalatroTbl = BalatroDataMgr.GetUsingBalatros()
    this.deleteTbl = {}
    this.addTbl = {}
    for key, value in pairs(curUsingBalatroTbl) do
        local balatroID = value:GetUID()
        local tempData = this.tempChooseBalatro[balatroID]
        if tempData == nil or tempData.selected == false then
            table.insert(this.deleteTbl, value)
        end
    end

    for key, value in pairs(this.tempChooseBalatro) do
        if value.selected == true and not curUsingBalatroTbl[key] then
            table.insert(this.addTbl, value.balatroData)
        end
    end
    local isChange = false
    if #this.deleteTbl > 0 or #this.addTbl > 0 then
        isChange = true
    end
    return NumTool.GetLen(this.tempChooseBalatro), isChange
end


this.ChooseBalatroBrand = function(params)
    this.CloseBrandInfoTips()
    local data = params[0]

    local balatroData = data.balatroData
    if data.selected == true and this.tempChooseCount >= BalatroConstVal.MaxBalatroBrandCount then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20014")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    elseif (not balatroData or balatroData:GetIsDestroy() == true) and data.selected == true then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20015")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if data.callback then
        data.callback(data.selected)
    end

    local balatroID = balatroData:GetUID()
    if data.selected == true then
        BalatroUtil.PlaySound(2)
        balatroData:SetTempSelected(true)
        this.otherBrandParentData:ChangeBalatroItem(balatroData, true)
        this.tempChooseBalatro[balatroID] = data
        this.tempChooseCount = this.tempChooseCount + 1
    else
        BalatroUtil.PlaySound(7)
        balatroData:SetTempSelected(false)
        this.otherBrandParentData:ChangeBalatroItem(balatroData, false)
        this.tempChooseBalatro[balatroID] = nil
        this.tempChooseCount = this.tempChooseCount - 1
    end
    if balatroData:GetIsDestroy() == true then
        BalatroDataMgr.SelectBrandGroup(balatroData, false)
    end
    this.RefreshChooseCount()
end


this.OnLongClickItem = function(item)
    this.CloseBrandInfoTips()

    local tempTips = nil
    local offsetY = 0
    local offsetX = 80
    if RaycastTool.GetMousePosition().y < LuaMgr.ScreenHeight() / 2 then
        tempTips = this.tipsTopData
        offsetY = 60
    else
        tempTips = this.tipsBottomData
        offsetY = -153
    end
    if tempTips == nil then
        LuaDebug.error("this.OnLongClickItem : UI绑定异常")
        return
    end
    local newPos = Vector3.zero
    local brandItemData = item:GetData()
    local gameObject = item:GetGameObject()
    local transferPos = RectTransformTool.ToContainer(gameObject.transform, tempTips.gameObject.transform.parent)
    tempTips:SetData(brandItemData)
    newPos.x = transferPos.x + offsetX
    newPos.y = transferPos.y + offsetY
    tempTips.gameObject.transform.localPosition = newPos
    SetActive(tempTips.gameObject, true)
    tempTips:SetData(brandItemData)
end

this.Update = function()
    if RaycastTool.GetMouseButtonDown(0) then
        this.screenPos = RaycastTool.GetMousePosition()
    end
    if this.screenPos == nil then
        return
    end
    if RaycastTool.GetMouseButtonUp(0) then
        local tempScreenPos = RaycastTool.GetMousePosition()
        local deltaPosX = tempScreenPos.x - this.screenPos.x
        local deltaPosY = tempScreenPos.y - this.screenPos.y
        LuaDebug.error("BalatroChangeForeverPopup this.Update DeltaPos(" .. deltaPosX .. "," .. deltaPosY .. ")")
        if math.abs(deltaPosX) > 0.3 or math.abs(deltaPosY) > 0.5 then

            this.CloseBrandInfoTips()
        end
    end
end

this.CloseBrandInfoTips = function()
    SetActive(this.tipsTop, false)
    SetActive(this.tipsBottom, false)
end

this.RefreshChooseCount = function()
    local color = ""
    if this.tempChooseCount < BalatroConstVal.MaxBalatroBrandCount then
        color = "#E5D4C5"
    else
        color = "#E64E67"
    end
    local tempStr = "%s/" .. BalatroConstVal.MaxBalatroBrandCount
    this.chooseCountText.text = string.format(tempStr, BalatroUtil.ColorText(color, this.tempChooseCount))
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.ScreenAdapter()
        this.before_awake()
        LuaMgr.AddClick(this.backBtn, this.OnClickBack)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm)
        LuaMgr.AddClick(this.maskBtn, this.CloseBrandInfoTips)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroChooseBalatroBrand, this.ChooseBalatroBrand)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.ParseParam(vm.behaviour.Params[0])
        this.before_active()
        LuaMgr.AddUpdate(this.Update)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.Update)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm)
        LuaMgr.RemoveClick(this.maskBtn, this.CloseBrandInfoTips)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroChooseBalatroBrand, this.ChooseBalatroBrand)
        UIScrollView.ClearItem("BalatroChangeForeverGroup")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)