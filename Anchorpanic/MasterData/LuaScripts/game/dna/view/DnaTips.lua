--[[
-----------------------------------------------------
    @CreateTime:2025/1/3 10:49:25
    @Author:zengweiwen
    @Copyright: (LY)2021 雷焰网络
    @Description:TODO
]]

module("game.dna.view.DnaTips", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("dna/DnaTips.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2  -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
end

function initData(self)
    self.mAttrItemList = {}
end

function configUI(self)
    self.mAriRole = self:getChildGO("mAriRole"):GetComponent(ty.AutoRefImage)
    self.mAriEgg = self:getChildGO("mAriEgg"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mAttrItem = self:getChildGO("mAttrItem")
    self.mAttrItem:SetActive(false)
    self.mTxtAttrName = self:getChildGO("mTxtAttrName"):GetComponent(ty.Text)
    self.mTxtAttrValue = self:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupSkill = self:getChildGO("mGroupSkill")
    self.mBaseAttrContent = self:getChildTrans("mBaseAttrContent")
    self.mTxtProplDesc = self:getChildGO("mTxtProplDesc"):GetComponent(ty.Text)
    self.mGroupPropDesc = self:getChildGO("mGroupPropDesc")
end

function initViewText(self)
    super.initViewText(self)
    self:getChildGO("mTxtLvTitle"):GetComponent(ty.Text).text = _TT(149904)
    self:getChildGO("mTxtSkillTitle"):GetComponent(ty.Text).text = _TT(149911)
    self:getChildGO("mTxtPropTitle"):GetComponent(ty.Text).text = _TT(149932)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickBtnCloseHandler)
end

function initArgs(self, args)
    self.type = args and args.type or nil
    self.cfgVo = args and args.cfgVo or nil
end

function active(self, args)
    super.active(self, args)
    self:initArgs(args)

    self:refreshView()
end

function deActive(self)
    super.deActive(self)
    self:initArgs()
    self:recoverAttrItem()
end

function recoverAttrItem(self)
    for k, item in pairs(self.mAttrItemList) do
        item:poolRecover()
        self.mAttrItemList[k] = nil
    end
    self.mAttrItemList = {}
end

function refreshView(self)
    local isEgg = self.type == hero.eggType.egg
    local isRole = self.type == hero.eggType.role
    self.mAriEgg.gameObject:SetActive(isEgg)
    self.mGroupPropDesc:SetActive(isEgg)
    self.mAriRole.gameObject:SetActive(isRole)
    self.mGroupSkill:SetActive(isRole)
    if isEgg then
        local eggDataCfgVo = self.cfgVo
        self.mAriEgg:SetImg(eggDataCfgVo:getDnaEggIconUrl())
        self.mTxtName.text = eggDataCfgVo:getName()
        local fullLevelLimit = eggDataCfgVo:getFullLevelLimit()

        self:refreshAttrInfo(eggDataCfgVo:getFullAttr(), fullLevelLimit, fullLevelLimit)

        local propsConfigVo = props.PropsManager:getPropsConfigVo(eggDataCfgVo.item_id)
        self.mTxtProplDesc.text = propsConfigVo:getDes()
    elseif isRole then
        local heroEggDataCfgVo = self.cfgVo
        self.mAriRole:SetImg(heroEggDataCfgVo:getDnaHeroRoleUrl())
        self.mTxtName.text = heroEggDataCfgVo:getName()
        local fullLevelLimit = heroEggDataCfgVo:getFullLevelLimit()
        self:refreshAttrInfo(heroEggDataCfgVo:getFullAttr(), fullLevelLimit, fullLevelLimit)

        local de_blocking = heroEggDataCfgVo:getSkillHeroEggLvDataByLv(fullLevelLimit)
        local heroSkillUpConfigVo = hero.HeroSkillUpManager:getSkillUpConfigVo(
            heroEggDataCfgVo.tid,
            de_blocking[1],
            de_blocking[2]
        )
        local skillVo = fight.SkillManager:getSkillRo(de_blocking[1])
        self.mTxtSkillName.text = skillVo:getName() .. "Lv." .. heroSkillUpConfigVo.skillLvl
        self.mTxtSkillDesc.text = heroSkillUpConfigVo:getDesc()
    end
end

--刷新属性栏
function refreshAttrInfo(self, attrList, lv, fullLevelLimit)
    attrList = attrList or {}
    local lvStr = "Lv.<size=30>%s</size>/%s"
    self.mTxtLv.text = string.format(lvStr, lv, fullLevelLimit)
    self:recoverAttrItem()
    for i, attrData in ipairs(attrList) do
        local item = SimpleInsItem:create(self.mAttrItem, self.mBaseAttrContent, "mAttrItem")
        local attrId, attrValue = attrData.key, attrData.value
        item:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrId)
        item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrId, attrValue)
        self.mAttrItemList[i] = item
    end
end

function onClickBtnCloseHandler(self)
    self:close()
end

return _M
