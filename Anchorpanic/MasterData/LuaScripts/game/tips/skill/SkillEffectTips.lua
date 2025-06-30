--[[ 
-----------------------------------------------------
@filename       : SkillTips
@Description    : 战员多技能tips
@date           : 2021-03-22 16:59:42
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("tips.SkillEffectTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/SkillEffectTips.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    self.m_instance = nil
    self.m_skillIdList = nil
    self.m_skillId = nil
    self.m_heroVo = nil
    self.m_skillItemList = {}
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
    self.mTouch = self:getChildGO("mTouch")
end

function active(self, args)
    super.active(self, args)
    self.title = args.data.title
    self.des = args.data.des
    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mTouch, self.onClickCloseHandler)
end

function updateView(self)
    self.mTxtSkillName.text = self.title
    if self.des then 
        self.mTxtSkillDesc.text = _TT(tonumber(self.des))
    else
        self.mTxtSkillDesc.text = ""
    end
    -- print()
end

function __updateSkillDes(self)
end

function onClickCloseHandler(self)
    self:close()
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
end

return _M
