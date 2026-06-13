local SingleFurnitureData = BaseClass("SingleFurnitureData")
local M = SingleFurnitureData

--初始化单个家具数据
function M:__init(id, type, cfg, gameObj, parentId, homeFurniturePoint, posIndex, templateId)
    self.id = id --家具唯一id
    self.type = type --家具类型
    self.cfg = cfg --家具配置表数据
    self.gameObj = gameObj --家具obj
    self.parentId = parentId --附属家具父id
    self.homeFurniturePoint = homeFurniturePoint ---家具配置点
    self.posIndex = posIndex ---房间位置（普通家具为类型，附属家具为附属点idx）
    self.TemplateId = templateId
    self.clickTimes = 0
    
    if self.type == DormConst.FurnitureType.AccessoryFurniture and self.gameObj then
        self.animator = self.gameObj.transform:GetAnimator()
        --获取日记effect
        if self.TemplateId == 215004 then
            self.outlineEffect = self.gameObj.transform:FindChildren('effect_home_dairy01')
            self.arrowEffect = self.gameObj.transform:FindChildren('effect_home_dairy02')
        end
    end
end

function M:PlayClickAnimation(callback)
    if not self.animator then
        return 
    end

    if self.outlineEffect then
        self.outlineEffect.gameObject:SetActive(false)
    end

    if self.arrowEffect then
        self.arrowEffect.gameObject:SetActive(false)
    end

    if callback then
        self.aniCallBack = callback
        local time = self.gameObj.transform:GetAnimationLength('Click')
        self.animatorTimer = TimerManager:GetInstance():GetTimer(time, Bind(self, self.PlayAnimationCalBack), nil, true)
        self.animatorTimer:Start()
    end

    self.animator:Play('Click')
end


function M:PlayNameAnimation(name, callback)
    if not self.animator then
        return 
    end

    if callback then
        self.aniCallBack = callback
        local time = self.gameObj.transform:GetAnimationLength('Click')
        self.animatorTimer = TimerManager:GetInstance():GetTimer(time, Bind(self, self.PlayAnimationCalBack), nil, true)
        self.animatorTimer:Start()
    end

    self.animator:Play(name)
end


function M:PlayAnimationCalBack()
    if self.outlineEffect then
        self.outlineEffect.gameObject:SetActive(true)
    end
    self.animatorTimer:Stop()
    self.aniCallBack()
end


function M:Dispose()
end


return SingleFurnitureData
