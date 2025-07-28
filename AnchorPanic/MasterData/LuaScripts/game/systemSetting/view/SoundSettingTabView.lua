--[[   
    系统设置
]]
module("role.SoundSettingTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("systemSetting/SoundSettingTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mQuality = nil
    self.mLoopSnList = {}
end

function configUI(self)
    super.configUI(self)

    self.mTextTitle1 = self:getChildGO("mTextTitle1"):GetComponent(ty.Text)
    self.mTextTitle2 = self:getChildGO("mTextTitle2"):GetComponent(ty.Text)

    self.mTextTotalSound = self:getChildGO("mTextTotalSound"):GetComponent(ty.Text)
    self.mTextBgSound = self:getChildGO("mTextBgSound"):GetComponent(ty.Text)
    self.mTextEffectSound = self:getChildGO("mTextEffectSound"):GetComponent(ty.Text)
    self.mTextModelSound = self:getChildGO("mTextModelSound"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTextTotalSound.text = _TT(62065) --"总音量"
    self.mTextBgSound.text = _TT(62056) --"背景音乐"
    self.mTextEffectSound.text = _TT(62057) --"游戏音效"
    self.mTextModelSound.text = _TT(62058) --"角色语音"
    self.mTextTitle1.text = _TT(62053) --"声音"
    self.mTextTitle2.text = _TT(62102) --"声音"
end

function addAllUIEvent(self)
    self:addSwichBtnEventAndVolumeState()
    self:initSliderListener()
end

function removeAllUIEvent(self)
    for _, v in pairs(self.mSliderDic) do
        v.slider.onValueChanged:RemoveAllListeners()
    end
    self.mSliderDic = nil
    self.mSwitchBtnDic = nil
end

function active(self)
    super.active(self)

    self.mSliderDic = {
        [systemSetting.SystemSettingDefine.totalVolume] = {
            slider = self:getChildGO("mSliderTotalVolume"):GetComponent(ty.Slider),
            textCom = self:getChildGO("mTextTotalSound_value"):GetComponent(ty.Text),
            img = self:getChildGO("mImgTotalSoundValue"):GetComponent(ty.Image),
            fill = self:getChildGO("mSliderTotalFill"):GetComponent(ty.Image)
        },
        [systemSetting.SystemSettingDefine.musicVolume] = {
            slider = self:getChildGO("mSliderBGVolume"):GetComponent(ty.Slider),
            textCom = self:getChildGO("mTextBgSound_value"):GetComponent(ty.Text),
            img = self:getChildGO("mImgBgSoundValue"):GetComponent(ty.Image),
            fill = self:getChildGO("mSliderBGFill"):GetComponent(ty.Image)
        },
        [systemSetting.SystemSettingDefine.voiceVolume] = {
            slider = self:getChildGO("mSliderModelVolume"):GetComponent(ty.Slider),
            textCom = self:getChildGO("mTextModelSound_value"):GetComponent(ty.Text),
            img = self:getChildGO("mImgModelSoundValue"):GetComponent(ty.Image),
            fill = self:getChildGO("mSliderModelFill"):GetComponent(ty.Image)
        },
        [systemSetting.SystemSettingDefine.soundEffectVolume] = {
            slider = self:getChildGO("mSliderSoundEffect"):GetComponent(ty.Slider),
            textCom = self:getChildGO("mTextEffectSound_value"):GetComponent(ty.Text),
            img = self:getChildGO("mImgEffectSoundValue"):GetComponent(ty.Image),
            fill = self:getChildGO("mSliderSoundFill"):GetComponent(ty.Image)
        },
    }

    self.mSwitchBtnDic = {
        [systemSetting.SystemSettingDefine.totalVolumeSwitch] = {
            img = self:getChildGO("mBtnSwitchTotalVolume"):GetComponent(ty.AutoRefImage),
            slider = self.mSliderDic[systemSetting.SystemSettingDefine.totalVolume].slider,
            fill = self.mSliderDic[systemSetting.SystemSettingDefine.totalVolume].fill,
        },
        [systemSetting.SystemSettingDefine.musicVolumeSwitch] = {
            img = self:getChildGO("mBtnSwitchBgVolume"):GetComponent(ty.AutoRefImage),
            slider = self.mSliderDic[systemSetting.SystemSettingDefine.musicVolume].slider,
            fill = self.mSliderDic[systemSetting.SystemSettingDefine.musicVolume].fill,
        },
        [systemSetting.SystemSettingDefine.voiceVolumeSwitch] = {
            img = self:getChildGO("mBtnSwitchModelVolume"):GetComponent(ty.AutoRefImage),
            slider = self.mSliderDic[systemSetting.SystemSettingDefine.voiceVolume].slider,
            fill = self.mSliderDic[systemSetting.SystemSettingDefine.voiceVolume].fill,
        },
        [systemSetting.SystemSettingDefine.soundEffectVolumeSwitch] = {
            img = self:getChildGO("mBtnSwitchEffectVolume"):GetComponent(ty.AutoRefImage),
            slider = self.mSliderDic[systemSetting.SystemSettingDefine.soundEffectVolume].slider,
            fill = self.mSliderDic[systemSetting.SystemSettingDefine.soundEffectVolume].fill,
        },
    }
end

function addSwichBtnEventAndVolumeState(self)
    for key, tab in pairs(self.mSwitchBtnDic) do
        local isOpen = systemSetting.SystemSettingManager:getSystemSettingBoolValue(key)
        local imgPath = isOpen and "arts/ui/pack/common5/common_0224.png" or "arts/ui/pack/common5/common_0225.png"
        tab.img:SetImg(imgPath, true)
        self:updateSliderState(tab.slider, isOpen, tab.fill)
        self:addUIEvent(tab.img.gameObject, self.onClickSwitchHandler, nil, key)
    end
end

function onClickSwitchHandler(self, key)
    local value = systemSetting.SystemSettingManager:getSystemSettingBoolValue(key)
    value = not value
    local imgPath = value and "arts/ui/pack/common5/common_0224.png" or "arts/ui/pack/common5/common_0225.png"
    self.mSwitchBtnDic[key].img:SetImg(imgPath, true)

    self:updateSliderState(self.mSwitchBtnDic[key].slider, value, self.mSwitchBtnDic[key].fill)
    local _value = value and 2 or 1
    systemSetting.SystemSettingManager:setSystemSettingValue(key, _value)
    systemSetting.SystemSettingManager:applySetting(key, _value)
end

function updateSliderState(self, slider, value, fill)
    slider.enabled = value
    local color = (not value) and "26D2FEFF" or "26D2FEFF"
    fill.color = gs.ColorUtil.GetColor(color)
    ColorUtil:setGray(slider.gameObject, not value)
end

function initSliderListener(self)
    for key, v in pairs(self.mSliderDic) do
        local onValueChanged = function(value)
            systemSetting.SystemSettingManager:setSystemSettingValue(key, value)
            systemSetting.SystemSettingManager:applySetting(key, value)
            v.textCom.text = value
            LoopManager:removeTimerByIndex(self.mLoopSnList[key])
            v.textCom:DOFade(1, 0.3)
            v.img:DOFade(1, 0.3)
            self.mLoopSnList[key] = LoopManager:addTimer(1, 1, self, function()
                --v.textCom:DOFade(0, 0.5)
                --v.img:DOFade(0, 0.5)
            end)
        end
        v.slider.onValueChanged:AddListener(onValueChanged)
        local value = systemSetting.SystemSettingManager:getSystemSettingValue(key)
        v.slider.value = value
        LoopManager:removeTimerByIndex(self.mLoopSnList[key])

        v.textCom.text = value
        v.textCom:DOFade(1, 0.3)
        v.img:DOFade(1, 0.3)
        self.mLoopSnList[key] = LoopManager:addTimer(1, 1, self, function()
            --v.textCom:DOFade(0, 0.5)
            --v.img:DOFade(0, 0.5)
        end)
    end
end

function deActive(self)
    super.deActive(self)
    for k, v in pairs(self.mLoopSnList) do
        if (v) then
            LoopManager:removeTimerByIndex(v)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(62065):	"总音量"
]]