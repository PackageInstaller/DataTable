module("tips.AssistSkillTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/AssistSkillTips.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    self.mSkillGrid = nil
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mSkillNode = self:getChildTrans("mSkillNode")
    self.mTxtSkillDes = self:getChildGO("mTxtSkillDes"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self.mHeroVo = args.heroVo
    self.mSkillVo = args.skillVo
    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

function updateView(self)
    self:recover()
    self.mSkillGrid = hero.HeroSkillItem2:create(self.mSkillNode, "SkillItem")
    self.mSkillGrid:setData(self.mHeroVo, self.mSkillVo, 1, 5)
    self.mTxtSkillDes.text = self.mSkillVo:getDesc()
end

function onClose(self)
    super.onClickClose(self)
end

function recover(self)
    if (self.mSkillGrid) then
        self.mSkillGrid:poolRecover()
        self.mSkillGrid = nil
    end
    super.recover(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
