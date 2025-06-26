module("braceletBuild.BraceletRefineSucPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/success/BraceletRefineSucPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.mRefGroupOld = self:getChildGO("mRefGroupOld")
    self.mRefGroupCur = self:getChildGO("mRefGroupCur")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
    self.mTxtDes_tmpLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtDes_tmpLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)
    self.mTxtRefOld = self:getChildGO("mTxtRefOld"):GetComponent(ty.Text)
    self.mTxtRefCur = self:getChildGO("mTxtRefCur"):GetComponent(ty.Text)

    self.mAni = self.UIObject:GetComponent(ty.Animator)
end

function active(self, args)
    super.active(self, args)
    self.mEquipVo = args.curEquipVo
    self:showPanel()
end

function onClickClose(self)
    self.mAni:SetTrigger("exit")

    local time = AnimatorUtil.getAnimatorClipTime(self.mAni, "BraceletRefineSucPanel_Exit")
    self:setTimeout(time,function ()
        super.onClickClose(self)
    end)
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    --self.m_textRefineTitle.text = _TT(4332) --"阶段"
end

function addAllUIEvent(self)
end

function showPanel(self)
    self.mTxtRefOld.text = self.mEquipVo.refineLvl - 1
    self.mTxtRefCur.text = self.mEquipVo.refineLvl
    local maxRefineLvl = braceletBuild.BraceletBuildManager:getMaxRefineLvl(self.mEquipVo.tid)
    local oldRefineLvl = self.mEquipVo.refineLvl - 1
    for i = 1, maxRefineLvl do
        self:getChildGO("mImgRelOld" .. i):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("bracelet/bracelet_refine_1.png"), false)
        self:getChildGO("mImgRelOld" .. i):GetComponent(ty.AutoRefImage).color = oldRefineLvl >= i and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("82898cff")
    end
    local curRefineLvl = self.mEquipVo.refineLvl
    for i = 1, maxRefineLvl do
        self:getChildGO("mImgRelCur" .. i):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath((curRefineLvl < maxRefineLvl) and "bracelet/bracelet_refine_1.png" or "bracelet/bracelet_refine_2.png"), false)
        if curRefineLvl < maxRefineLvl then 
             self:getChildGO("mImgRelCur" .. i):GetComponent(ty.AutoRefImage).color= curRefineLvl >= i and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("82898cff")
        end
    end

    local skillEffectList, skillEffectDic = self.mEquipVo:getSkillEffect()
    --local skillVo = fight.SkillManager:getSkillRo(skillEffectList[1].skillId)
    --self.mTxtSkill.text = skillVo:getName()
    self.mTxtDes.text = equip.EquipSkillManager:getBraceletSkillDes(self.mEquipVo, skillEffectList[1])
    local i={}
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
