module('recruit.RecruitLogItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mTextQuality = self.m_childTrans['mTextQuality']:GetComponent(ty.Text)
    self.mTextPlayerName = self.m_childTrans['mTextPlayerName']:GetComponent(ty.Text)
    self.mTextTime = self.m_childTrans['mTextTime']:GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)

    local logVo = self.data
    local recruitType = recruit.RecruitManager:getRecruitTypeById(logVo.recruit_id)

    if recruitType == recruit.RecruitType.RECRUIT_BRACELETS
        or recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS
        or recruitType == recruit.RecruitType.RECRUIT_ACTIVITY_2 then
        local itemConfigVo = props.PropsManager:getPropsConfigVo(logVo.itemTid)

        self.mTextQuality.text = HtmlUtil:color(hero.getColorName(itemConfigVo.color), ColorUtil:getPropColor(itemConfigVo.color))
        self.mTextPlayerName.text = itemConfigVo:getName()
    else
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(logVo.itemTid)

        self.mTextQuality.text = HtmlUtil:color(heroConfigVo:getColorName(), ColorUtil:getPropColor(heroConfigVo.color))
        self.mTextPlayerName.text = heroConfigVo.name
    end

    self.mTextTime.text = TimeUtil.getFormatTimeBySeconds_7(logVo.time)
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
