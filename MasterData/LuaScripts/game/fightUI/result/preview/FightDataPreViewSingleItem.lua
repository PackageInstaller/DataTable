module("fightUI.FightDataPreViewSingleItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.ImgHead_1 = self:getChildGO("ImgHead_1"):GetComponent(ty.AutoRefImage)
    self.ImgHead_2 = self:getChildGO("ImgHead_2"):GetComponent(ty.AutoRefImage)

    self.mOutputName = self:getChildGO("mOutputName"):GetComponent(ty.Text)
    self.mOutputScore = self:getChildGO("mOutputScore"):GetComponent(ty.Text)
    self.mOutputPercent = self:getChildGO("mOutputPercent"):GetComponent(ty.Text)
    self.mOutputBar = self:getChildGO("mOutputBar"):GetComponent(ty.Image)

    self.mInjuredName = self:getChildGO("mInjuredName"):GetComponent(ty.Text)
    self.mInjuredScore = self:getChildGO("mInjuredScore"):GetComponent(ty.Text)
    self.mInjuredPercent = self:getChildGO("mInjuredPercent"):GetComponent(ty.Text)
    self.mInjuredBar = self:getChildGO("mInjuredBar"):GetComponent(ty.Image)

    self.mTreatName = self:getChildGO("mTreatName"):GetComponent(ty.Text)
    self.mTreatScore = self:getChildGO("mTreatScore"):GetComponent(ty.Text)
    self.mTreatPercent = self:getChildGO("mTreatPercent"):GetComponent(ty.Text)
    self.mTreatBar = self:getChildGO("mTreatBar"):GetComponent(ty.Image)

    self.mTextLvl = self:getChildGO("mTextLvl"):GetComponent(ty.Text)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)

    -- self.starList = {}
    -- for i = 1, 6 do
    --     self.starList[i] = self:getChildGO("mStar0" .. i)
    -- end

    self.mOutputName.text = _TT(3066)
    self.mInjuredName.text = _TT(3067)
    self.mTreatName.text = _TT(3038)

end

function setData(self, data)
    super.setData(self, data)
    if data.side == 1 then
        local heroVo = hero.HeroManager:getHeroVo(data.heroId)
        if heroVo == nil then
            heroVo = monster.MonsterManager:getMonsterVo01(self.data.tid)
            self.ImgHead_2:SetImg(UrlManager:getFormationHeadUrl(heroVo:getShowModelld()), true)
            self.ImgHead_1.gameObject:SetActive(false)
            self.ImgHead_2.gameObject:SetActive(true)
        else
            --self.ImgHead_1:SetImg(UrlManager:getPainImg(heroVo.painting),false)
            self.ImgHead_1:SetImg(UrlManager:getFormationHeadUrl(heroVo:getHeroModel()), true)
            self.ImgHead_1.gameObject:SetActive(true)
            self.ImgHead_2.gameObject:SetActive(false)
        end

        if heroVo then

            for i = 1, 6 do 
                self.m_childGos["mStar0" .. i]:SetActive(true)
                self.m_childGos["mStar0" .. i]:GetComponent(ty.Image).color = (i <= self.data.evolution) and gs.ColorUtil.GetColor("000000ff") or gs.ColorUtil.GetColor("0000004c")
            end

            self.mTextLvl.text = "LV." .. self.data.lv
            self.mTextName.text = heroVo.name
        end
    else
        local monsterVo = monster.MonsterManager:getMonsterVo01(self.data.tid)
        if monsterVo then
            for i = 1, 6 do
                self.m_childGos["mStar0" .. i]:SetActive(false)
            end

            self.mTextLvl.text = "LV." .. self.data.lv
            self.mTextName.text = monsterVo.name

            self.ImgHead_2:SetImg(UrlManager:getFormationHeadUrl(monsterVo:getShowModelld()), false)
            self.ImgHead_1.gameObject:SetActive(false)
            self.ImgHead_2.gameObject:SetActive(true)
        end
    end


    self.mOutputScore.text = data.hurt
    self.mInjuredScore.text = data.bearHurt
    self.mTreatScore.text = data.addBlood

    self.mOutputBar.fillAmount = data.hurtScale / 1000
    self.mOutputPercent.text = string.format("%s%%", data.hurtScale / 10)

    self.mInjuredBar.fillAmount = data.bearHurtScale / 1000
    self.mInjuredPercent.text = string.format("%s%%", data.bearHurtScale / 10)

    self.mTreatBar.fillAmount = data.addBloodScale / 1000
    self.mTreatPercent.text = string.format("%s%%", data.addBloodScale / 10)
end

function onDelete(self)
    super.onDelete(self)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3038):	"治疗"
	语言包: _TT(3067):	"承伤"
	语言包: _TT(3066):	"输出"
	语言包: _TT(3039):	"功能"
	语言包: _TT(3038):	"治疗"
	语言包: _TT(35):	"防御"
	语言包: _TT(34):	"攻击"
]]