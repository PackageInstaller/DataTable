--[[ 
-----------------------------------------------------
@filename       : GmFightSettingItem
@Description    : GM
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("gm.GmFightSettingItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
	self.mTitleTxt = self:getChildGO("TitleTxt"):GetComponent(ty.Text)

    local typeDropdown = self:getChildGO("Dropdown"):GetComponent(ty.Dropdown)
    self.mTypeDropdown = DropDownEx.new()
    self.mTypeDropdown:bandDropDown(typeDropdown)

    self.minput = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.mGoBtn = self:getChildGO("GOBtn")

    local function _setupFrameCount()
        local ret = self.minput.text
        if ret and #ret>0 then
            local frameCount = tonumber(ret)
            gs.Application.targetFrameRate = frameCount
        end
    end
    self:addOnClick(self.mGoBtn, _setupFrameCount)

    --场景切换
    local function _sceneChange(val)
        val = val+1
        if self.mPostData.key == 5 then
            if val==2 then
                gs.ApplicationUtil.BlendWeights(gs.SkinWeights.FourBones)
            elseif val==3 then
                gs.ApplicationUtil.BlendWeights(gs.SkinWeights.TwoBones)
            end
        elseif self.mPostData.key == 6 then
            local cameraCom1 = gs.CameraMgr:GetSceneCamera()
            if cameraCom1 then
                if val==2 then
                    cameraCom1.allowHDR = true
                elseif val==3 then
                    cameraCom1.allowHDR = false
                end
            end
            local cameraCom2 = gs.CameraMgr:GetDefSceneCamera()
            if cameraCom2 then
                if val==2 then
                    cameraCom2.allowHDR = true
                elseif val==3 then
                    cameraCom2.allowHDR = false
                end
            end
        elseif self.mPostData.key == 7 then
            local cameraCom1 = gs.CameraMgr:GetSceneCamera()
            if cameraCom1 then
                local mono = cameraCom1:GetComponent(ty.CommandBufferBlur)
                if mono then
                    if val==2 then
                        gs.GoUtil.SetMonoEable(mono, true)
                    elseif val==3 then
                        gs.GoUtil.SetMonoEable(mono, false)
                    end
                end
            end
            local cameraCom2 = gs.CameraMgr:GetDefSceneCamera()
            if cameraCom2 then
                local mono = cameraCom2:GetComponent(ty.CommandBufferBlur)
                if mono then
                    if val==2 then
                        gs.GoUtil.SetMonoEable(mono, true)
                    elseif val==3 then
                        gs.GoUtil.SetMonoEable(mono, false)
                    end
                end
            end
        else
            if not systemSetting.SystemSettingManager:getCurQualityIsCustom() then
                for i = 2, #systemSetting.QualitySettingDrop do
                    local _value = systemSetting.QualitySettingDrop[i]
                    if _value.key ~= self.mPostData.key then
                        systemSetting.SystemSettingManager:setSystemSettingValue(_value.key, systemSetting.SystemSettingManager:getSystemSettingValue(_value.key))
                    end
                end
                systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality,systemSetting.QualitySetting_Grade.Custom)
            end

            systemSetting.SystemSettingManager:setSystemSettingValue(self.mPostData.key,val)
            if self.mPostData.key ~= systemSetting.SystemSettingDefine.effect then
                systemSetting.SystemSettingManager:applySetting(self.mPostData.key,val)
            end
        end
    end
    self.mTypeDropdown:removeAllListeners()
    self.mTypeDropdown:addValueChangedListener(_sceneChange)
end

function setData(self, param)
    super.setData(self, param)
    self.mPostData = param
    self.mTitleTxt.text = param.title

    self.mTypeDropdown:AddOptions(param.label)

    local val = systemSetting.SystemSettingManager:getSystemSettingValue(self.mPostData.key)
    if val then
        self.mTypeDropdown:setValueWithNoNotify(val)
    else
        self.mTypeDropdown:setValueWithNoNotify(1)
        systemSetting.SystemSettingManager:setSystemSettingValue(self.mPostData.key, 1)
    end
    if self.mPostData.key == systemSetting.SystemSettingDefine.frameCount then 
        self.minput.gameObject:SetActive(true)
        self.mGoBtn:SetActive(true)
    else
        self.minput.gameObject:SetActive(false)
        self.mGoBtn:SetActive(false)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
