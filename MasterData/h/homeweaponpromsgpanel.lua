---@class HomeWeaponProMsgPanel : HomeWeaponProMsgPanel_Generate
---##################### 【HomeWeaponProMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeWeaponProMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeWeaponProMsgPanel = require "HomeWeaponProMsgPanel_Generate"

function HomeWeaponProMsgPanel:InitLogic(data)
    self.nowBlueprintId = nil   --当前蓝图ID
    self.nowSelectIndex = nil    --当前选中的武器索引
    self.weaponObjList = {}    --武器列表
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function HomeWeaponProMsgPanel:StartCreating(time)
--
--end

--function HomeWeaponProMsgPanel:StartEnter(time)
--
--end

--function HomeWeaponProMsgPanel:StartRemoving(time)
--
--end

--function HomeWeaponProMsgPanel:StartExit(time)
--
--end

function HomeWeaponProMsgPanel:OnOpen(data, initiative)
    if data then
        self.nowBlueprintId = data.Id
    end
    self:setView()
end

function HomeWeaponProMsgPanel:setView()
    LuaLogger.ds("self.nowBlueprintId", self.nowBlueprintId)
    --确认这个图纸能产出哪些武器，显示左侧武器列表
    --根据图纸ID，获取图纸信息
    local blueprintData = Config.GetWeaponProductionInfo(self.nowBlueprintId)
    if blueprintData then
        --根据图纸信息，获取产出武器信息
        local total = tablex.size(blueprintData.produceShow)
        self:FillTemplateContent(self.customBox, self.weaponList, total, function(index, customBox)
            local weaponConfig = Config.GetWeaponInfo(blueprintData.produceShow[index])
            if weaponConfig then
                local data = {
                    id = weaponConfig.id,
                    type = GE.RewardType.Weapon,
                    num = 0,
                }
                local customData = {
                    clickSound = self.btnSoundPath,
                    listener = function()
                        self:setSelect(index)
                    end
                }

                local temp = {
                    obj = customBox,
                    index = index,
                    config = weaponConfig,
                    customData = customData,
                    rewardData = data,
                }
                table.insert(self.weaponObjList, temp)
                customBox.customBox:setMono(self)
                customBox.customBox:SetUIData(data, customData)
            end
            if index == total then
                self:setSelect(1, true)
            end
        end)
    end
end

--设置选中的武器
---@param index integer
function HomeWeaponProMsgPanel:setSelect(index,isRefresh)
    if self.nowSelectIndex == index and not isRefresh then
        return
    end

    self.nowSelectIndex = index
    ---@type WeaponTable
    local weaponConfig = nil
    --根据武器ID，获取武器信息
    for _, value in pairs(self.weaponObjList) do
        if value.index == self.nowSelectIndex then
            value.customData.isSelect = true
            weaponConfig = value.config
        else
            value.customData.isSelect = false
        end
        value.obj.customBox:setMono(self)
        value.obj.customBox:SetUIData(value.rewardData, value.customData)
    end
    if not weaponConfig or not weaponConfig.name then
        return
    end
    self.weaponNameTxt.text.text = weaponConfig.name
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponTypePath, weaponConfig.type), self.weaponTypeIcon.image)
    self.typeNameTxt.text.text = weaponConfig.weaponTypeDec
    self:FillTemplateContent(self.weaponLoadBox, self.weaponLoadList, weaponConfig.load, function(index, weaponLoadBox)
        weaponLoadBox:SetActive(true)
    end)
    self.accuracyTxt.text.text = weaponConfig.accuracy[1].."-"..weaponConfig.accuracy[2]
    self.qualityTxt.text.text = weaponConfig.quality[1].."-"..weaponConfig.quality[2]

    local msgIdList = {}
    for _, entryData in pairs(weaponConfig.entry5) do
        local entryConfig = Config.GetWeaponEntryInfoByGroup(entryData[1])
        for _, entry in pairs(entryConfig) do
            table.insert(msgIdList, entry.attribute)
        end
    end
    self:FillTemplateContent(self.skillMsgBox, self.msgList, tablex.size(msgIdList), function(index, skillMsgBox)
        skillMsgBox:SetActive(true)
        local msgConfig = Config.GetSkillInfo(msgIdList[index])
        skillMsgBox.msgTxt.text.text = msgConfig.desKey
    end)

end

--function HomeWeaponProMsgPanel:OnClose(initiative)
--
--end

--function HomeWeaponProMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomeWeaponProMsgPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function HomeWeaponProMsgPanel:mask_Button_onClick(mask)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

--[[
/BoxBg/CloseBtn onClick 
--]]
function HomeWeaponProMsgPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

function HomeWeaponProMsgPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return HomeWeaponProMsgPanel
