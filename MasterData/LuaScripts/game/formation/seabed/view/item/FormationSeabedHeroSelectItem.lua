module('formation.FormationSeabedHeroSelectItem', Class.impl(formation.FormationHeroSelectItem))

function __update(self)
    super.__update(self)

    
    local heroVo = self.data:getDataVo().dataVo

    local rate = seabed.SeabedManager:getHpRate(heroVo.id)
    self.mImgProBar.fillAmount = rate / 100
    self.mTxtCont.text = rate .. "%"

    if rate >= 60 then
        self.mImgProBar.color = gs.ColorUtil.GetColor("31f860FF")
    elseif rate > 20 and rate < 60 then
        self.mImgProBar.color = gs.ColorUtil.GetColor("d1bc39FF")
    else
        self.mImgProBar.color = gs.ColorUtil.GetColor("e6526cFF")
    end
    self.mGroupHeroHp:SetActive(true)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1256):	"已阵亡"
]]
