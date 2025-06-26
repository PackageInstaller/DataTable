--[[ 
-----------------------------------------------------
@filename       : SpecialEffectTip
@Description    : 战员多技能tips
@date           : 2021-03-22 16:59:42
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("tips.SpecialEffectTip", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/SpecialEffectTips.prefab")

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
    self.mSkillVoList = {}
    self.mSpecialItemList = {}
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mGroup = self:getChildTrans("mGroup")
    self.mItem = self:getChildGO("SpecialItem")
end

function active(self, args)
    super.active(self, args)
    self.mSkillVoList = args
    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

function updateView(self)
    self:recoverItem()
    for k, v in pairs(self.mSkillVoList) do 
        local item = SimpleInsItem:create(self.mItem, self.mGroup, "SpecialEffectTipSpecialItem")
        local name = item:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
        local icon = item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
        local des = item:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
        name.text = v:getName()
        icon:SetImg(UrlManager:getSkillIconPath(v:getIcon()), false)
        des.text = v:getDesc()
        table.insert(self.mSpecialItemList, item)
    end
end

function recoverItem(self)
    for k, v in pairs(self.mSpecialItemList) do 
        if v then 
            v:poolRecover()
        end
    end
    self.mSpecialItemList = {}
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4066):	"(未解锁)"
	语言包: _TT(1340):	"军阶-"
	语言包: _TT(1340):	"军阶-"
	语言包: _TT(71316):	"敬请期待"
]]
