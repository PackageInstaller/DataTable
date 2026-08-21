---@class HomeDisposeRoleBox : HomeDisposeRoleBox_Generate
---##################### 【HomeDisposeRoleBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeDisposeRoleBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeDisposeRoleBox = require "HomeDisposeRoleBox_Generate"

function HomeDisposeRoleBox:InitLogic(data)

end

---@class HomeDisposeRoleBoxData
---@field constructionId integer
---@field isSel boolean
---@field posIndex integer
---@field roleId integer
---@field clickFunc function

---@param data HomeDisposeRoleBoxData
function HomeDisposeRoleBox:refreshUI(data)
    LuaLogger.ds(tablex.dump(data))
    self.data = data
    self.selImg:SetActive(data.isSel)
    if data.roleId and data.roleId ~= 0 then
        self.role:SetActive(true)
        self.addImg:SetActive(false)
        local roleData = Me:getPlayerHero(data.roleId)
        if not roleData then
            return
        end
        local roleConfig = Config.GetCharacterInfo(data.roleId)
        local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
        local resourceFolder = nil
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        local CutRolePath = string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey)
        self:LoadSpriteAsync(CutRolePath, self.role.image)
        self.roleName.text.text = roleConfig.name
    else
        self.addImg:SetActive(true)
        self.role:SetActive(false)
    end
    self:addClick()
    if data.constructionId == GE.CoustructionEnum.CommandRoom then
        self.pos.text.text = LocalStrEnum["ConstructionJobName_1000" .. data.posIndex]
    else
        self.pos.text.text = LocalStrEnum["VarietyDescribe_10009"..(data.posIndex - 1)]
    end
end

function HomeDisposeRoleBox:addClick()
    self.scaleButton.onClick:RemoveAllListeners()
    if not self.data.clickFunc then
        return
    end
    self.scaleButton.onClick:AddListener(self.data.clickFunc)
end

--function HomeDisposeRoleBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/Root onClick 
--]]
function HomeDisposeRoleBox:scaleButton_ScaleButton_onClick(scaleButton)

end

return HomeDisposeRoleBox
