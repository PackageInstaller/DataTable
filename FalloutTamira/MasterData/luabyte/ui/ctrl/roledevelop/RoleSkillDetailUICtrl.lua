-- RoleSkillUI_Describe
local RoleSkillDetailUICtrl = BaseClass("RoleSkillDetailUICtrl", BaseUICtrl)
local M = RoleSkillDetailUICtrl
local JBattleLevel = CS.GameBase.JBattleLevel
local sfmt = string.format

function M:Init()
    self.levelLight = {}

    for i = 1, 3 do
        self.levelLight[i] = self._view["levelLight" .. i]
    end
    self._view.curDesc:SetOnClick(Bind(self, self.OnClickCurHrefWord))
    self._view.nextDesc:SetOnClick(Bind(self, self.OnClickNextHrefWord))
end

function M:OnEnter(heroData, data, target)
    self.heroData = heroData
    self.data = data
    self.target = target
    local info = data.battleLevel

    if data.type == 1 or data.type == 2 then -- 普攻和觉醒技能
        self:_RefreshBaseSkill(info)
    elseif data.type == 3 or data.type == 4 then -- 战中技能
        self:_RefreshBattleLevelSkill(info)
    elseif data.type == 5 then -- 边舱技能
        self:_RefreshOtakuSkill(info)
    end
    self._view.ItemEquipPosCtrl:Init(self.target.gameObject, self._view.tfContent.gameObject, self._view.tfMask.gameObject, Bind(self, self.Close))
end

function M:OnClickCurHrefWord(hrefName, centerX, centerY)
    local alignDir = Vector2.New(-0.5, 0) -- 点击处 -- 以点击文字的锚点居中为标准，对齐点在右侧居中位置
    local tipsPivot = Vector2.New(1, 0.5) -- 弹出框 -- tips以左侧居中点对齐文字的对齐点
    local worldPos = Vector3.New(centerX, centerY, 0)
    self._view.curDesc:ShowHrefWordTips(hrefName, worldPos, alignDir, tipsPivot)
end

function M:OnClickNextHrefWord(hrefName, centerX, centerY)
    local alignDir = Vector2.New(-0.5, 0)
    local tipsPivot = Vector2.New(1, 0.5)
    local worldPos = Vector3.New(centerX, centerY, 0)
    self._view.nextDesc:ShowHrefWordTips(hrefName, worldPos, alignDir, tipsPivot)
end

-- 普攻 觉醒技能
function M:_RefreshBaseSkill(info)
    local heroId = self.heroData:GetHeroId()
    local state = not self.data.isOpen
    self._view.lifePanel:SetActive(state)

    if state then
        local heroName = ConfigHelper.GetHeroName(heroId)
        local tips = ConfigHelper.GetLocalString(5229)
        tips = sfmt(tips, heroName)
        self._view.powerText:SetText(tips)
    end

    self._view.skillName1:SetText(info.name)
    self._view.icon1:SetPic(info.icon)
    self._view.skillLv:SetText("Max")

    self._view.skillType:SetText(info.type)
    self._view.curDesc:SetText(info.desc)
    self._view.nextDescGo:SetActive(info.nextDesc > 0)
    self._view.nextDescTitleGo:SetActive(info.nextDesc > 0)
    self._view.nextDesc:SetText(info.nextDesc)

    self._view.skillCost:SetText(tostring(info.cost))
    self._view.skillCostGo:SetActive(info.cost > 0)
    self._view.skillMold:SetText(info.mold)
    self._view.tfMod:SetActive(true)
    self._view.tfType:SetActive(true)
    self._view.tfSkill1:SetActive(true)
    self._view.tfSkill2:SetActive(false)
end

-- 边舱技能
function M:_RefreshOtakuSkill(info)
    local heroId = self.heroData:GetHeroId()
    local state = not self.data.isOpen
    self._view.lifePanel:SetActive(state)

    if state then
        local heroName = ConfigHelper.GetHeroName(heroId)
        local tips = ConfigHelper.GetLocalString(self.data.lockTips)
        self._view.powerText:SetText(heroName .. tips)
    end

    self._view.skillName2:SetText(info.name)
    self._view.icon2:SetPic(info.icon)

    if info.level == 0 then
        self._view.skillLv:SetText("1")
    else
        self._view.skillLv:SetText(tostring(info.level))
    end

    self._view.skillType:SetText(info.type)
    self._view.curDesc:SetText(info.desc)
    self._view.nextDescGo:SetActive(info.nextDesc ~= nil)
    self._view.nextDescTitleGo:SetActive(info.nextDesc ~= nil)
    if info.nextDesc then
        self._view.nextDesc:SetText(info.nextDesc)
    end
    self._view.skillCost:SetText(tostring(info.cost))
    self._view.skillCostGo:SetActive(info.cost > 0)
    self._view.skillMold:SetText(info.mold)
    self._view.tfMod:SetActive(false)
    self._view.tfType:SetActive(false)
    self._view.tfSkill1:SetActive(false)
    self._view.tfSkill2:SetActive(true)
end

-- 战中技能
function M:_RefreshBattleLevelSkill(cfg)
    local skinId = self.heroData:GetSkinId()
    local skillLevel = cfg.skillLevel + 1
    local nextdata = JBattleLevel.GetHeroBattleLevel(skinId, cfg.grade, skillLevel)

    local heroId = self.heroData:GetHeroId()
    local state = not self.data.isOpen
    self._view.lifePanel:SetActive(state)

    if state then
        local heroName = ConfigHelper.GetHeroName(heroId)
        local tips = ConfigHelper.GetLocalString(5716)
        tips = sfmt(tips, heroName)
        self._view.powerText:SetText(tips)
    end

    self._view.skillName1:SetText(cfg.skillName)
    self._view.icon1:SetPic(cfg.icon)

    self._view.skillLv:SetText(tostring(cfg.skillLevel))
    self._view.skillType:SetText(cfg.skillType + 909)
    self._view.curDesc:SetText(cfg.skillDesc)
    self._view.nextDescGo:SetActive(not IsNull(nextdata))
    self._view.nextDescTitleGo:SetActive(not IsNull(nextdata))

    if not IsNull(nextdata) then
        self._view.nextDesc:SetText(nextdata.skilldescribe)
    end

    self._view.skillCost:SetText(tostring(cfg.skillCost))
    self._view.skillCostGo:SetActive(cfg.skillCost > 0)
    self._view.skillMold:SetText(491)
    self._view.tfMod:SetActive(true)
    self._view.tfType:SetActive(true)
    self._view.tfSkill1:SetActive(true)
    self._view.tfSkill2:SetActive(false)
end

function M:OnDeviceBack()
    return self:Close()
end

function M:Close()
    self.target:SetIsOn(false, false)
    M.super.Close(self)
end

return RoleSkillDetailUICtrl
