--[[ 
-----------------------------------------------------
@filename       : FightTabView
@Description    : 战斗场景设置面板
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('gm.FightTabView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('gm/FightTabView.prefab')

function configUI(self)
    super.configUI(self)
    self.mSceneInput = self:getChildGO("SceneNameInput"):GetComponent(ty.InputField)
    self.mModelInput = self:getChildGO("ModelNameInput"):GetComponent(ty.InputField)
    self:addOnClick(self:getChildGO("SureBtn"), self._sureClick)
    self:addOnClick(self:getChildGO("ReductionBtn"), self._reductionClick)
    self:addOnClick(self:getChildGO("mBtnHideEnvironment"), self.onHideEnvironmenty)

    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(gm.GmFightPostItem)

    self.mSettingScroller = self:getChildGO("SettingLyScroller"):GetComponent(ty.LyScroller)
    self.mSettingScroller:SetItemRender(gm.GmFightSettingItem)

    local function _toggleNorCall(bVal)
        fight.FightManager.m_gmOpenAudio = bVal
    end
    self:getChildGO("ToggleNor"):GetComponent(ty.Toggle).isOn = fight.FightManager.m_gmOpenAudio or false
    self:getChildGO("ToggleNor"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleNorCall)

    local function _toggleTurnCall(bVal)
        fight.FightManager.m_gmOpenEft = bVal
    end
    self:getChildGO("ToggleTrun"):GetComponent(ty.Toggle).isOn = fight.FightManager.m_gmOpenEft or false
    self:getChildGO("ToggleTrun"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleTurnCall)

    local function _toggleEnemyEffCall(bVal)
        fight.FightManager.m_gmOpenEnemyEft = bVal
    end
    self:getChildGO("ToggleEnemyEff"):GetComponent(ty.Toggle).isOn = fight.FightManager.m_gmOpenEnemyEft or false
    self:getChildGO("ToggleEnemyEff"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleEnemyEffCall)

    local function _toggleShaderCall(bVal)
        fight.FightManager.m_gmOpenLowShader = bVal
        fight.SceneManager:SetOpenLowShader(bVal)
    end
    self:getChildGO("ToggleShader"):GetComponent(ty.Toggle).isOn = fight.FightManager.m_gmOpenLowShader or false
    self:getChildGO("ToggleShader"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleShaderCall)

    local function _togglePostprocessCall(bVal)
        fight.FightManager.m_gmOpenPostprocess = bVal
        fight.SceneManager:SetCameraPostprocessEnable(bVal)
    end
    self:getChildGO("TogglePostprocess"):GetComponent(ty.Toggle).isOn = fight.FightManager.m_gmOpenPostprocess or false
    self:getChildGO("TogglePostprocess"):GetComponent(ty.Toggle).onValueChanged:AddListener(_togglePostprocessCall)


    local function _toggleTimerDebugl(bVal)
        RootLoop.TimerDebug = bVal
    end
    self:getChildGO("ToggleTimerDebug"):GetComponent(ty.Toggle).isOn = RootLoop.TimerDebug or false
    self:getChildGO("ToggleTimerDebug"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleTimerDebugl)

    local function _toggleCameraNear(bVal)
        self.fightCameraObj = fight.FightCamera:getCameraTrans():GetComponent(ty.Camera)
        if bVal == true then
            self.fightCameraObj.nearClipPlane = 1
        else
            self.fightCameraObj.nearClipPlane = 0.01
        end
       
    end
    self:getChildGO("ToggleCameraNear"):GetComponent(ty.Toggle).isOn = false
    self:getChildGO("ToggleCameraNear"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleCameraNear)

    local function _toggleRoleLodDebug(bVal)
        fight.FightManager.m_gmRoleLod = bVal
    end
    self:getChildGO("ToggleLodDebug"):GetComponent(ty.Toggle).isOn = fight.FightManager.m_gmRoleLod == nil and true or fight.FightManager.m_gmRoleLod
    self:getChildGO("ToggleLodDebug"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleRoleLodDebug)

    local function _ZClick()
        if self.mSkillEditorUI then return end
        gs.PopPanelManager.CloseAll()
        GameView.mainUI.gameObject:SetActive(false)
        self.mSkillEditorUI = gs.ResMgr:LoadGO(UrlManager:getPrefabPath('tools/SkillEditorUI.prefab'))
        self.mSkillEditorUI.transform:SetParent(GameView.subPop, false)
    end
    self:addOnClick(self:getChildGO("ZXBtn"), _ZClick)

    self.InputField_Y = self:getChildGO("InputField_Y"):GetComponent(ty.InputField)

    local quality_value = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.quality)
    local height = 0
    if quality_value == 1 then
        height = 450
    elseif quality_value == 2 then
        height = 560
    elseif quality_value == 3 then
        height = 720
    elseif quality_value == 4 then
        height = 960
    elseif quality_value == 5 then
        height = 1080
    end
    self.InputField_Y.text = height

    self:addOnClick(self:getChildGO("Button_SetResolution"),SetResolution)
end

function SetResolution(self)
    local height = tonumber(self.InputField_Y.text)
    if gs.Application.isMobilePlatform then
        if height <= 1080 then 
            local width = height / gs.Screen.height * gs.Screen.width 
            gs.CameraMgr:SetResolution(width, height)
        else
            gs.CameraMgr:ResetRenderCamera()
            gs.ScreenResolutionUtil.SetResolutionLv01(height)
        end
    else
        local width = height / gs.Screen.height * gs.Screen.width 
        gs.CameraMgr:SetResolution(width, height)
    end
end

function active(self)
    super.active(self)
    local t = {}
    for i = 1, 12 do
        table.insert(t, fight.FightDef["GM_POST" .. i])
    end
    self.mScroller.DataProvider = t
    -- self.mScroller.DataProvider = fight.FightManager:getReplayData()

    local tab = {}
    for i=2,#systemSetting.QualitySettingDrop do
        local t = {}
        for k,v in pairs(systemSetting.QualitySettingDrop[i]) do
            t[k] = v
        end
        if systemSetting.QualitySettingDrop[i].key == systemSetting.SystemSettingDefine.quality then 
            t.label = systemSetting.getResolutionLabel()
        end
        table.insert(tab, t)
    end
    
    if not gs.Application.isMobilePlatform then
        local settingParam = {key = systemSetting.SystemSettingDefine.windowResolution, title = _TT(62094), isDownDrop = true}
        local label = {}
        local resolutionList = systemSetting.SystemSettingManager:getAllwindowResolution()
        for i=1,#resolutionList do
            if resolutionList[i].width == 1920 then 
                label[i] = string.format("%sx%s%s",resolutionList[i].width,resolutionList[i].height,_TT(62095))
            else
                label[i] = string.format("%sx%s%s",resolutionList[i].width,resolutionList[i].height,_TT(62096))
            end
        end
        settingParam.label = label
        table.insert(tab,1, settingParam)
    end

    for i=1,#fight.FightDef.TEMP_SETTING_DATAs do
        table.insert(tab,fight.FightDef.TEMP_SETTING_DATAs[i])
    end

    self.mSettingScroller.DataProvider = tab
end

function onHideEnvironmenty(self)
    local sceneCtrl = map.MapLoader.m_ctrlMap[map.MapLoader.m_curMapType]
    local sceneRo = fight.SceneManager:getSceneData(sceneCtrl:getMapID())
    if sceneRo then
        local rootObj = gs.GameObject.Find(U3DSceneUtil:getSceneRootName(sceneRo:getScene()))
        if (rootObj) then
            local environmentTrans = rootObj.transform:Find("Environment")
            environmentTrans.gameObject:SetActive(not environmentTrans.gameObject.activeSelf)
        end
    end
end

--执行
function _sureClick(self)
    local sname = self.mSceneInput.text
    local mname = self.mModelInput.text
    if #sname == 0 then
        sname = nil
    end
    if #mname == 0 then
        mname = nil
        gs.Message.Show(string.format("指定场景为 [%s] ", tostring(sname)))
    else
        mname = tonumber(mname)
        local hvo = hero.HeroManager:getHeroConfigVo(mname)
        if not hvo then
            gs.Message.Show(string.format("没有[%d]的战员", tostring(mname)))
            return
        end
        gs.Message.Show(string.format("指定场景为 [%s]  指定战员为 [%s] ", tostring(sname), hvo.name))
    end
    fight.FightManager:_setGmData(sname, mname)
end

--还原
function _reductionClick(self)
    fight.FightManager:_setGmData()
    self.mSceneInput.text = ""
    self.mModelInput.text = ""
    gs.Message.Show("还原为默认场景和战员")
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]