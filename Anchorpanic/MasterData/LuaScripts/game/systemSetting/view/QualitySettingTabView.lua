--[[   
    系统设置
]]
module("role.QualitySettingTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("systemSetting/QualitySettingTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtPictureTitle = self:getChildGO("mTxtPictureTitle"):GetComponent(ty.Text)
    self.mTxtDIYTitle = self:getChildGO("mTxtDIYTitle"):GetComponent(ty.Text)
    self.mTxtBgNotch = self:getChildGO("mTxtBgNotch"):GetComponent(ty.Text)
    self.mTxtNotchCB = self:getChildGO("mTxtNotchCB"):GetComponent(ty.Text)

    self.mPictureQuality = self:getChildGO("mPictureQuality")
    self.mNotchToogle = self:getChildGO("mNotchToogle")
    self.mNotchToggleImg = self:getChildGO("mNotchToggleImg")
    self.mToggleBg = self:getChildGO("mImgToggleBg")
    self.mSliderNotchScript = self:getChildGO("mSliderNotchScript"):GetComponent(ty.Slider)
    self.mBackground = self:getChildGO("mBackground"):GetComponent(ty.AutoRefImage)

    self.mSettingItem = self:getChildGO("mSettingItem")
    self.mSettingToggle = self:getChildGO("mSettingToggle")
    self.mSettingDown = self:getChildGO("mSettingDown")
    self.mGroupSettingContent = self:getChildGO("mGroupSettingContent")
    self.mGroupToggleContent = self:getChildGO("mGroupToggleContent")
    self.mTxtPictureTips = self:getChildGO("mTxtPictureTips"):GetComponent(ty.Text)

    self.mItemToggle = self:getChildGO("mItemToggle")
    self.mItemToggle:SetActive(false)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtPictureTitle.text = _TT(62059)
    self.mTxtDIYTitle.text = _TT(62062)
    self.mTxtBgNotch.text = _TT(62054) --"UI适配"
    self.mTxtNotchCB.text = _TT(62055) --"自动"
end


function addAllUIEvent(self)
    local function notchValueUpdate(value)
        systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.notch_Value, self.mSliderNotchScript.value)
        systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.notch_Value)
    end
    self.mSliderNotchScript.onValueChanged:AddListener(notchValueUpdate)

    self:addUIEvent(self.mNotchToogle, self.onClickNotchToggle)
end


function removeAllUIEvent(self)
    self.mSliderNotchScript.onValueChanged:RemoveAllListeners()
end

function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SYSTEM_WINDOWRESOLUTION_UPDATE, self.onSystemWindowResolution, self)
    GameDispatcher:addEventListener(EventName.SYSTEM_QUALITY_UPDATE, self.refreshQualityTips, self)


    self.mOldQuality = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality)
    self.mSettingItem:SetActive(false)
    self.mSettingToggle:SetActive(false)
    self.mSettingDown:SetActive(false)

    self.mNotchValue = systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.notch_Auto)
    self.mSliderNotchScript.value = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.notch_Value)

    self:initSetting()
    self:updateNoteAutoState()
    self:refreshQualityTips()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.SYSTEM_WINDOWRESOLUTION_UPDATE, self.onSystemWindowResolution, self)
    GameDispatcher:removeEventListener(EventName.SYSTEM_QUALITY_UPDATE, self.refreshQualityTips, self)


    local nowQuality = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality)
    if (self.mOldQuality ~= nowQuality) then
        local value = systemSetting.getOneQualitySettingDrop(systemSetting.SystemSettingDefine.pictureQuality)
        if (value and value.label and value.label[nowQuality]) then
            local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.QUALITY_SELECTION, value.label[nowQuality])
            WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
        end
    end

    systemSetting.SystemSettingManager:savePlayerPrefsSystemSetting()
end

--更新画质流畅提示
function refreshQualityTips(self)
    --获取当前推荐的画质
    local deviceName, cpuName, gpuName = sdk.SdkManager:getDeviceData()
    local curRecommendQuality = systemSetting.SystemSettingManager:getDeviceQualityType(deviceName, cpuName, gpuName) 
    --获取当前档位配置的参数
    local qualityConfig = systemSetting.SystemSettingManager:getSystemQualitySettingVo(curRecommendQuality)
    local value = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.quality)

    if value <= qualityConfig[systemSetting.SystemSettingDefine.quality] then 
        self.mTxtPictureTips.text = _TT(62104)
    else
        self.mTxtPictureTips.text = _TT(62105)
    end
end

--分辨率改变
function onSystemWindowResolution(self)
    LoopManager:setFrameout(5,nil,function() 
        if ScreenUtil:isSmallScreen() then
            self.mNotchValue = true
            self:updateNoteAutoState()
            systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.notch_Auto, true)
        end
    end)
end

function onClickNotchToggle(self)
    if ScreenUtil:isSmallScreen() then
        self.mNotchValue = true
        gs.Message.Show("当前分辨率无法使用该功能")
    else
        self.mNotchValue = not self.mNotchValue
    end

    self:updateNoteAutoState()
    systemSetting.SystemSettingManager:setSystemSettingBoolValue(systemSetting.SystemSettingDefine.notch_Auto, self.mNotchValue)
    systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.notch_Auto)
end

function updateNoteAutoState(self)
    if self.mNotchValue then
        self.mBackground:SetImg(UrlManager:getPackPath("common/common_5224.png"), true)
        self.mSliderNotchScript.enabled = false
        ColorUtil:setGray(self.mSliderNotchScript.gameObject, true)
        self.mNotchToggleImg:SetActive(true)
        self.mToggleBg:SetActive(false)
    else
        local value = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.notch_Value) or 0
        self.mBackground:SetImg(UrlManager:getPackPath("common/common_5223.png"), true)
        self.mSliderNotchScript.enabled = true
        ColorUtil:setGray(self.mSliderNotchScript.gameObject, false)
        self.mNotchToggleImg:SetActive(false)
        self.mToggleBg:SetActive(true)
    end

end

--获取一个新的多选toggle
function createToggle(self, go, title)
    local toggle = {}
    toggle.go = go
    toggle.m_childGos, toggle.m_childTrans = GoUtil.GetChildHash(go)

    toggle.m_childGos["mTxt_title"]:GetComponent(ty.Text).text = title

    toggle.mGroupItems = toggle.m_childTrans["mGroupItems"]

    toggle.value = 1
    toggle.CreateOptionItems = function(_toggle)
        if not _toggle.items then
            _toggle.items = {}
        end
        for i = 1, #_toggle.options do
            if _toggle.items[i] == nil then
                local item = SimpleInsItem:create(self.mItemToggle, _toggle.mGroupItems,self.__cname .. "toggleItem")
                item:setText("mTxtToggle", nil, toggle.options[i])
                item.show = function(_item,value)
                    _item:getChildGO("mImg"):SetActive(value)
                    _item:getChildGO("mBackground"):SetActive(not value)
                end

                local function toggleCall()
                    _toggle:setValueWithOutNotify(i)
                end
                item:addUIEvent("mClickAre", toggleCall)

                _toggle.items[i] = item
            else
                _toggle.items[i]:setActive(true)
            end
        end
    end
    --重新添加选项
    toggle.AddOptions = function(_toggle, options)
        if _toggle.items then
            if #_toggle.items > #options then
                for i = #options, #_toggle.items do
                    _toggle.items[i]:setActive(false)
                end
            end
        end

        _toggle.options = options
        _toggle:CreateOptionItems()
        _toggle:setValueWithNoNotify(_toggle.value)
    end
    --添加单个选项
    toggle.AddOption = function(_toggle, option)
        if not _toggle.options then
            _toggle.options = {}
        end

        table.insert(_toggle.options, option)
        _toggle:CreateOptionItems()
    end

    --不回调事件
    toggle.setValueWithNoNotify = function(_toggle, value)
        if value <= 0 then
            value = 1
        elseif value > #_toggle.options then
            value = #_toggle.options
        end

        _toggle.value = value
        _toggle:show()
    end

    --回调事件
    toggle.setValueWithOutNotify = function(_toggle, value)
        if value <= 0 then
            value = 1
        elseif value > #_toggle.options then
            value = #_toggle.options
        end

        _toggle.value = value
        _toggle:show()

        if _toggle.notifyEvent then
            _toggle.notifyEvent(_toggle.value)
        end
    end

    toggle.show = function(_toggle)
        for i = 1, #_toggle.items do
            _toggle.items[i]:show(i == _toggle.value)
        end
    end
    toggle.destroy = function(_toggle)
        for i = 1, #_toggle.items do
            _toggle.items[i]:removeAllUIEvent()
            _toggle.items[i]:poolRecover()
        end
    end

    return toggle
end

---只有两个选项的复选按钮
function createToggle2(self, item, title)
    item:setText("mTxtTitle", nil, title)
    item:setText("mTxtOpen", 62063, "开")
    item:setText("mTxtClose", 62064, "关")

    local toggle = {}
    toggle.value = 1
    local click = function()
        local val = toggle.value == 1 and 2 or 1
        toggle:setValueWithOutNotify(val)
    end
    item:addUIEvent("mClick", click)

    toggle.setValueWithNoNotify = function(_toggle, val)
        _toggle.value = val
        _toggle:show(systemSetting.SystemSettingManager:getIsOpen(val))
    end

    toggle.setValueWithOutNotify = function(_toggle, val)
        _toggle.value = val

        _toggle:show(systemSetting.SystemSettingManager:getIsOpen(val))
        if _toggle.notifyEvent then
            _toggle.notifyEvent(_toggle.value)
        end
    end
    --1为打开，其余为关闭
    toggle.show = function(_toggle, val)
        item:getChildGO("mGroupOpen"):SetActive(val)
        item:getChildGO("mGroupClose"):SetActive(not val)
    end

    toggle.destroy = function(_toggle)
        item:removeAllUIEvent()
    end

    return toggle
end

--创建下拉的控件
function createDownDrop(self, item, key, tile)
    local down = DropDownEx.new()
    down:bandDropDown(item:getChildGO("mDropdown"):GetComponent(ty.Dropdown) )
    down:addValueChangedListener(function (value)
        if down.notifyEvent then 
            down.notifyEvent(value + 1)
        end
        if key == systemSetting.SystemSettingDefine.windowResolution then
            systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.windowResolution, value + 1)
            systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.windowResolution, value + 1)
        end
    end)

    down.destroy = function (_toggle)
        _toggle:removeAllListeners()
    end
    item:getChildGO("mTxt_title"):GetComponent(ty.Text).text = tile
    return down
end

--更新下拉Item的参数跟默认数值
function initSetting(self)
    if not self.mSettingItemList then
        self.mSettingItemList = {}
    end

    local QualitySettingParam = {}
    QualitySettingParam[1] = systemSetting.QualitySettingDrop[1]

    if not gs.Application.isMobilePlatform then
        local settingParam = {key = systemSetting.SystemSettingDefine.windowResolution, title = _TT(62094), isDownDrop = true}
        local label = {}
        local resolutionList = systemSetting.SystemSettingManager:getAllwindowResolution()
        for i=1,#resolutionList do
            if i == 1 then 
                label[i] = string.format("%sx%s%s",resolutionList[i].width,resolutionList[i].height,_TT(62095))
            else
                label[i] = string.format("%sx%s%s",resolutionList[i].width,resolutionList[i].height,_TT(62096))
            end
        end
        settingParam.label = label
        QualitySettingParam[2] = settingParam
    end

    for i=2,#systemSetting.QualitySettingDrop do
     
        --if systemSetting.QualitySettingDrop[i].key ~= systemSetting.SystemSettingDefine.gyro then
            table.insert(QualitySettingParam, systemSetting.QualitySettingDrop[i])
        -- else
        --     if gs.Application.isMobilePlatform  then
        --         table.insert(QualitySettingParam, systemSetting.QualitySettingDrop[i])
        --     end
        -- end
        
    end
  
    if gs.Application.isMobilePlatform  then
        local param = { key = systemSetting.SystemSettingDefine.gyro, title = _TT(282), label = { _TT(62086), _TT(62087) }, isToggle = true }--陀螺仪
        table.insert(QualitySettingParam, param)
    end
    for i = 1, #QualitySettingParam do
        local _value = QualitySettingParam[i]
        local _key = _value.key

        local tIcon = self.mSettingItemList[_key]
        if tIcon == nil then
            if _key == systemSetting.SystemSettingDefine.pictureQuality then
                local toggle = self:createToggle(self.mPictureQuality, _value.title)
                tIcon = {control = toggle}
            elseif _value.isToggle then --两个选项的toggle
                tIcon = SimpleInsItem:create(self.mSettingToggle, self.mGroupToggleContent.transform, self.__cname .. "mSettingToggle")
                local toggle = self:createToggle2(tIcon, _value.title)
                tIcon.control = toggle
            elseif _value.isDownDrop then 
                tIcon = SimpleInsItem:create(self.mSettingDown, self.mGroupSettingContent.transform, self.__cname .. "mSettingDown")
                local downDorp = self:createDownDrop(tIcon, _key, _value.title)
                tIcon.control = downDorp
            else --多个选项的toggle
                tIcon = SimpleInsItem:create(self.mSettingItem, self.mGroupSettingContent.transform, self.__cname .. "mSettingItem")
                local toggle = self:createToggle(tIcon.m_go, _value.title)
                tIcon.control = toggle
            end
            self.mSettingItemList[_key] = tIcon

            local valueUpate = function(value)
                systemSetting.SystemSettingManager:setSystemSettingValue(_key, tonumber(value))

                if _key == systemSetting.SystemSettingDefine.windowResolution then
                    return 
                end

                --其他值改变的时候，画质变为自定义,并且重新设置为上次一个画质设置的参数
                if _key ~= systemSetting.SystemSettingDefine.pictureQuality then
                    if not systemSetting.SystemSettingManager:getCurQualityIsCustom() then
                        self.mSettingItemList[systemSetting.SystemSettingDefine.pictureQuality].control:AddOption(_TT(62062))
                        self.mSettingItemList[systemSetting.SystemSettingDefine.pictureQuality].control:setValueWithNoNotify(5)
                        systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality, 5)

                        --取上一次的画质设置
                        for i = 2, #systemSetting.QualitySettingDrop do
                            local _value = systemSetting.QualitySettingDrop[i]
                            if _value.key ~= _key then
                                systemSetting.SystemSettingManager:setSystemSettingValue(_value.key, self.mSettingItemList[_value.key].control.value)
                            end
                        end
                    end
                else
                    if not systemSetting.SystemSettingManager:getCurQualityIsCustom() then
                        local label = self:getQualityLabel()
                        self.mSettingItemList[systemSetting.SystemSettingDefine.pictureQuality].control:AddOptions(label)
                        self.mSettingItemList[systemSetting.SystemSettingDefine.pictureQuality].control:setValueWithNoNotify(value)
                    end
                    self:upateQualityParams()
                end
            end
            tIcon.control.notifyEvent = valueUpate
        end

        if tIcon ~= nil then
            local label = _value.label
            if _key == systemSetting.SystemSettingDefine.pictureQuality then
                label = self:getQualityLabel()
            elseif _key == systemSetting.SystemSettingDefine.quality then 
                label = systemSetting.getResolutionLabel()
            end

            if not _value.isToggle then 
                tIcon.control:AddOptions(label)
            end
        end
    end

    local val = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality)
    self.mSettingItemList[systemSetting.SystemSettingDefine.pictureQuality].control:setValueWithOutNotify(val)
end

--获取画质选项的文本
function getQualityLabel(self)
    local deviceName, cpuName, gpuName = sdk.SdkManager:getDeviceData()
    local curRecommendQuality = systemSetting.SystemSettingManager:getDeviceQualityType(deviceName, cpuName, gpuName) 
    local initLabel = systemSetting.QualitySettingDrop[1].label
    local labellist = {}
    for i = 1, #initLabel do
        local label = initLabel[i]
        if curRecommendQuality == i then
            label = initLabel[i] .. _TT(62091)
        end
        table.insert(labellist, label)
    end

    --随便取一个参数，值为0则证明没有设置过值
    if systemSetting.SystemSettingManager:getCurQualityIsCustom() then
        table.insert(labellist, _TT(62062))
    end
    return labellist
end

--更新画质的具体参数配置
function upateQualityParams(self)
    if not self.mSettingItemList then return end

    for key,v in pairs(self.mSettingItemList) do
        if key ~= systemSetting.SystemSettingDefine.pictureQuality then 

            --取不到值，证明没有设置过自定义参数。取上次画质的参数，并且缓存
            local val = systemSetting.SystemSettingManager:getSystemSettingValue(key)
            if val then
                v.control:setValueWithNoNotify(val)
            else
                systemSetting.SystemSettingManager:setSystemSettingValue(key, v.control.value)
            end
        end
    end
end

function destroy(self, isAuto)
    super.deActive(self, isAuto)

    for _, v in pairs(self.mSettingItemList or {}) do
        v.control:destroy()
    end
    if (self.mSettingItemList) then
        for key,v in pairs(self.mSettingItemList) do
            if key ~= systemSetting.SystemSettingDefine.pictureQuality then 
                v:poolRecover()
            end
        end
    end
    self.mSettingItemList = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(62062):	"自定义"
	语言包: _TT(62062):	"自定义"
	语言包: _TT(62062):	"自定义"
	语言包: _TT(62059):	"图像"
]]