--用于扩展UIImage的类
local GameUIImage = BaseClass("GameUIImage", UIImage)
local M = GameUIImage

--设置道具ICON
function M:SetItemIcon(itemId)
    self.unity_uiimage:SetItemIcon(itemId)
end

--设置角色图标
function M:SetAvatarIcon(templateId, type,dataOrigin)
    if dataOrigin == nil then 
        dataOrigin = 2
    end
    self.unity_uiimage:SetAvatarIcon(templateId, type,dataOrigin)
end

--设置战中英雄图标
function M:SetBatleIcon(heroId,dataOrigin)
    if dataOrigin == nil then 
        dataOrigin = 2
    end
    self.unity_uiimage:SetBatleIcon(heroId,dataOrigin)
end

--设置图片颜色
function M:SetColor(r, g, b, a)
    a = a or 255
    self.unity_uiimage:SetColor(r / 255, g / 255, b / 255, a / 255)
end

function M:SetColorNew(color)
    return self.unity_uiimage:SetColor(color.r / 255, color.g / 255, color.b / 255, color.a / 255)
end

function M:SetColorByColor(color)
    return self.unity_uiimage:SetColor(color.r / 1, color.g / 1, color.b / 1, color.a / 1)
end

function M:SetColorTo16(colorStr)
    return self.unity_uiimage:SetColor(colorStr)
end

--设置英雄职业图标
function M:SetProfessional(heroId)
    self.unity_uiimage:SetProfessional(heroId)
end

function M:SetProfessionalByType(type)
    self.unity_uiimage:SetProfessionalByType(type)
end

--设置英雄稀有度图标
function M:SetHeroRare(heroId)
    self.unity_uiimage:SetHeroRare(heroId)
end

function M:SetHeroImageName(heroId)
    self.unity_uiimage:SetHeroImageName(heroId)
end 

--设置品质颜色
function M:SetQuality(quality)
    self.unity_uiimage:SetQuality(quality)
end

--设置图片填充量
function M:SetFillAmount(value)
    self.unity_uiimage:SetFillAmount(value)
end

--获取图片填充量
function M:GetFillAmount()
    return self.unity_uiimage:GetFillAmount()
end

--设置技能图标
function M:SetSkillIcon(skillId)
    self.unity_uiimage:SetSkillIcon(skillId)
end

--设置技能图标
function M:SetBattleLevelIcon(battleLvId)
    self.unity_uiimage:SetBattleLevelIcon(battleLvId)
end

function M:SetItemQuality(itemId)
    self.unity_uiimage:SetItemQuality(itemId)
end

function M:SetEnable(enable)
    self.unity_uiimage.enabled = enable
end

--用于展示的半身像
function M:SetShowHalf(templateId,type,dataOrigin)
    if dataOrigin == nil then 
        dataOrigin = 2
    end
    self.unity_uiimage:SetShowHalf(templateId,type,dataOrigin)
end

--编队界面半身像
function M:SetImageHalf(templateId,type,dataOrigin)
    if dataOrigin == nil then 
        dataOrigin = 2
    end
    self.unity_uiimage:SetImageHalf(templateId,type,dataOrigin)
end

function M:SetDoFade(endValue, duration, ease)
    if not ease then
        ease = 1
    end
    return self.unity_uiimage:SetDoFade(endValue, duration, ease)
end

function M:SetBlink(fadeInDuration, fadeOutDuration, interval, value)
    self.unity_uiimage:SetBlink(fadeInDuration, fadeOutDuration, interval, value)
end

function M:GetMaterial()
    return self.unity_uiimage.material
end

function M:IsContainPoint(screenPoint)
    return self.unity_uiimage:IsContainPoint(screenPoint)
end

return GameUIImage
