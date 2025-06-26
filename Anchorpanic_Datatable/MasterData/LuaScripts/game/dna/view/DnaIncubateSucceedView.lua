--[[
-----------------------------------------------------
   @CreateTime:2024/12/25 15:17:59
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:TODO
]]

module("game.dna.view.DnaIncubateSucceedView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("dna/DnaIncubateSucceedView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
end

function initData(self)
end

function configUI(self)
    self.mTxtSkillLvup = self:getChildGO("mTxtSkillLvup"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtNameDesc = self:getChildGO("mTxtNameDesc"):GetComponent(ty.Text)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mTxtSkilllNameDesc = self:getChildGO("mTxtSkilllNameDesc"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mNodeFrameAniPrefab = self:getChildTrans("mNodeFrameAniPrefab")
end

function initViewText(self)
    super.initViewText(self)
    -- self:setBtnLabel(self.mBtnTask, nil, "通行任务")
    -- self:getChildGO("mTxtType"):GetComponent(ty.Text).text = _TT(98106)
    self.mTxtSkillLvup.text = _TT(149911)
    self.mTxtDes.text = _TT(149157)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    -- self:addUIEvent(self.mBtnCloseMask, self.close)
end

function active(self, args)
    super.active(self)

    self.dnaFrameAniCtrl = dna.DnaFrameAniCtrl.new()
    self.dnaFrameAniCtrl:active()
    self.dnaFrameAniCtrl:initUiRef(true,
        self.mNodeFrameAniPrefab
    )

    local heroId = args.heroId
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataCfgVoByHeroId(heroId)

    local de_blocking = heroEggDataCfgVo:getSkillHeroEggLvDataByLv()
    local heroSkillUpConfigVo = hero.HeroSkillUpManager:getSkillUpConfigVo(
        heroVo.tid,
        de_blocking[1],
        de_blocking[2]
    )
    local skillVo = fight.SkillManager:getSkillRo(de_blocking[1])
    self.mTxtSkillName.text = skillVo:getName() .. "Lv." .. heroSkillUpConfigVo.skillLvl
    self.mTxtSkilllNameDesc.text = heroSkillUpConfigVo:getDesc()

    self.dnaFrameAniCtrl:refreshRole(heroEggDataCfgVo:getDnaRoleFrameAniUrl(), heroEggDataCfgVo.tid)
    local bubbleData = heroEggDataCfgVo:getRandomBubbleDataByType(heroEggDataCfgVo.frameAniType.happy)
    self.dnaFrameAniCtrl:playAni(bubbleData.type)
    self.mTxtNameDesc.text = bubbleData.txt

    self.mTxtName.text = heroEggDataCfgVo:getName()

end

function deActive(self)
    super.deActive(self)

    self.dnaFrameAniCtrl:deActive()
    self.dnaFrameAniCtrl = nil
end

return _M
