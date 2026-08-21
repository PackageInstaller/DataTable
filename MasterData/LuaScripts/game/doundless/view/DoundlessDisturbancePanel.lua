module("doundless.DoundlessDisturbancePanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("doundless/DoundlessDisturbancePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 540)
    self:setTxtTitle(_TT(97055))
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)

end

function configUI(self)
    super.configUI(self)

    self.mImgSkill = self:getChildGO("mImgSkill"):GetComponent(ty.AutoRefImage)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mTxtRadio = self:getChildGO("mTxtRadio"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtRadioDes = self:getChildGO("mTxtRadioDes"):GetComponent(ty.Text)
end

function initViewText(self)
    self:getChildGO("mTxtTips"):GetComponent(ty.Text).text  = _TT(97054)
end

function addAllUIEvent(self)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
end

function showPanel(self)
    self.roundId = doundless.DoundlessManager:getServeRoundId()
    self.warId = doundless.DoundlessManager:getServerWayId()
    self.cityId = doundless.DoundlessManager:getServerCityId()
    local roundVo = doundless.DoundlessManager:getDoundlessRoundData(self.roundId, self.warId, self.cityId)

   
    local skillRo = fight.SkillManager:getSkillRo(roundVo.mSkillId)
    self.mImgSkill:SetImg(UrlManager:getSkillIconPath(skillRo:getIcon()), false) 
    self.mTxtSkillName.text = skillRo:getName()
    self.mTxtDes.text = skillRo:getDesc()

    self.mDisturbanceId = doundless.DoundlessManager:getDistubanceId()
    local cityData = doundless.DoundlessManager:getDoundlessCityDataByWar(self.warId)

    local distanceVo = cityData:getDistributeData(self.cityId,self.mDisturbanceId)
    self.mTxtRadio.text = _TT(97014) .. distanceVo.radio
    self.mTxtRadioDes.text = _TT(distanceVo.des)
end

return _M