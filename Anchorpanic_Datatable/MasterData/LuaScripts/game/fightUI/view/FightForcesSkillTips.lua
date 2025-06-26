--[[ 
-----------------------------------------------------
@filename       : FightForcesSkillTips
@Description    : 战斗UI上的漂浮技能tips 盟约技能
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.fightUI.view.FightForcesSkillTips', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fight/FightForcesSkillTips.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0
isAddMask = 0 --窗口模式下是否需要添加mask (1 添加 0 不添加)


--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnPrevent = self:getChildGO("mBtnPrevent")

    self.mImgBg = self:getChildTrans("mImgBg")
    self.mGroup = self:getChildGO("mGroup")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
    self.mTxtDesLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mImgCount = self:getChildGO("mImgCount")
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtCostLab = self:getChildGO("mTxtCostLab"):GetComponent(ty.Text)
    self.mImgFlag = self:getChildGO("mImgFlag"):GetComponent(ty.AutoRefImage)
    self.mTxtFlag = self:getChildGO("mTxtFlag"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)

    self.mTxtRange = self:getChildGO("mTxtRange"):GetComponent(ty.Text)
    self.mImgRange = self:getChildGO("mImgRange"):GetComponent(ty.AutoRefImage)

    self.mGroupMilitaryEffect = self:getChildGO("mGroupMilitaryEffect")
    self.mImgMilitaryLock = self:getChildGO("mImgMilitaryLock")
    self.mImgMilitaryIcon = self:getChildGO("mImgMilitaryIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtMilitaryTitle = self:getChildGO("mTxtMilitaryTitle"):GetComponent(ty.Text)
    self.mTxtMilitaryName = self:getChildGO("mTxtMilitaryName"):GetComponent(ty.Text)
    self.mTxtMilitaryDes = self:getChildGO("mTxtMilitaryDes"):GetComponent(ty.TMP_Text)
    self.mTxtMilitaryDesLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtMilitaryDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mTxtMilitarySkillTip = self:getChildGO("mTxtMilitarySkillTip"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mSkillRo = args.skillRo
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_FORCES_SKILL_TIPS)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPrevent, self.onClickClose)
end

function updateView(self)
    self.mTxtTitle.text = self.mSkillRo:getName()
    self.mTxtDes.text = self.mSkillRo:getDesc()
end

function __playOpenAction(self)

end
function __closeOpenAction(self)
    self:close()
end

return _M