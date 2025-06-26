module("hero.DnaSkillAllLvTipsView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("dna/DnaSkillAllLvTipsView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)

    self.gBtnClose:SetActive(false)
    if (self.base_childGos["gImgBg2"]) then
        self.base_childGos["gImgBg2"]:SetActive(false)
    end
    if (self.base_childGos["gImgBg3"]) then
        self.base_childGos["gImgBg3"]:SetActive(false)
    end
end

function initData(self)
    self.mItemList = {}
end

function configUI(self)
    self.mItemGroup = self:getChildGO("mItemGroup")
    self.mItemGroup:SetActive(false)
    self.Content = self:getChildTrans("Content")
end

function initViewText(self)
    super.initViewText(self)
    self:getChildGO("mTxtTitle"):GetComponent(ty.Text).text = _TT(149939)
end

function initArgs(self, args)
    self.heroVo = args and args.heroVo or nil
    self.heroEggDataCfgVo = args and args.heroEggDataCfgVo or nil
    self.cur_de_blocking = args and args.cur_de_blocking or nil
    self.isActiveSkill = args and args.isActiveSkill or nil
end

function active(self, args)
    super.active(self)
    self:initArgs(args)

    self:refreshView()
end

function deActive(self)
    super.deActive(self)
    self:initArgs()

    self:recoverItem()
end

function recoverItem(self)
    for k, item in pairs(self.mItemList) do
        item:poolRecover()
        self.mItemList[k] = nil
    end
    self.mItemList = {}
end

function refreshView(self)
    self:recoverItem()
    local lvDataList = self.heroEggDataCfgVo:getAllSkillInfoDataList()
    local curSkillLv = self.cur_de_blocking ~= nil and self.cur_de_blocking[2] or 0
    for i, lvData in ipairs(lvDataList) do
        local item = SimpleInsItem:create(self.mItemGroup, self.Content, "mItemGroup")
        local mTxtActiveDesc = item:getChildGO("mTxtActiveDesc")
        local mTxtCurLv = item:getChildGO("mTxtCurLv")

        mTxtCurLv:GetComponent(ty.Text).text = _TT(149938)
        mTxtActiveDesc:GetComponent(ty.Text).text = (self.isActiveSkill or i ~= 1) and _TT(149937, lvData.needLv) or _TT(149936)

        local heroSkillUpConfigVo = hero.HeroSkillUpManager:getSkillUpConfigVo(
            self.heroVo.tid,
            lvData.id,
            lvData.lv
        )
        local skillVo = fight.SkillManager:getSkillRo(lvData.id)
        local skillName = skillVo:getName()
        skillName = skillName .. "Lv." .. heroSkillUpConfigVo.skillLvl
        local skillDesc = heroSkillUpConfigVo:getDesc()

        local isGrey = (self.isActiveSkill and curSkillLv >= lvData.lv)
        local nameColor = isGrey and "FFFFFFFF" or "82898CFF"
        local descColor = isGrey and "C6D4E1FF" or "82898CFF"
        
        local mTxtSkillName = item:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
        mTxtSkillName.text = skillName
        mTxtSkillName.color = gs.ColorUtil.GetColor(nameColor)

        local mTxtSkillDesc = item:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
        mTxtSkillDesc.text = skillDesc
        mTxtSkillDesc.color = gs.ColorUtil.GetColor(descColor)

        mTxtCurLv:SetActive(self.isActiveSkill and curSkillLv == lvData.lv)
        if self.isActiveSkill then
            mTxtActiveDesc:SetActive(curSkillLv < lvData.lv)
        else
            mTxtActiveDesc:SetActive(true)
        end

        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(mTxtSkillDesc.transform)
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(item:getGo().transform)


        self.mItemList[i] = item
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content)
end

return _M
