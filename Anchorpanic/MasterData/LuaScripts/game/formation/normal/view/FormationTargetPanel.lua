module("formation.FormationTargetPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("formation/FormationTargetPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function getManager(self)
    return self.mManager
end

function setManager(self, cusManager)
    self.mManager = cusManager
end


-- 析构函数
function dtor(self)
    super.dtor(self)
end

function initData(self)
    self.mItemList = {}
end

-- 初始化UI
function configUI(self)
    super.configUI(self)

    self.mTipTxt = self:getChildGO("mTipTxt"):GetComponent(ty.Text)
    self.mConTxt = self:getChildGO("mConTxt"):GetComponent(ty.Text)
    self.mTargetScroller = self:getChildGO("mTargetScroller"):GetComponent(ty.ScrollRect)
    self.mTargetItem = self:getChildGO("mTargetItem")
end

function initViewText(self)
    self:getChildGO("mTipTxt"):GetComponent(ty.Text).text = _TT(99571)
    self:getChildGO("mConTxt"):GetComponent(ty.Text).text = _TT(97972)
end

function active(self, args)
    super.active(self, args)

    self:setManager(args.manager)
    self.manager = args.data.manager
    self.vo = args.data.vo

    self:clearItems()
    for i = 1, #self.vo.targetList do
        local id = self.vo.targetList[i]
        local vo = doundless.DoundlessManager:getDoundlessCityTargetData(id)
        local item = SimpleInsItem:create(self.mTargetItem, self.mTargetScroller.content, "myFormationPanelTargetItem")
        item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(vo.des) .. _TT(97051,vo.point)
        table.insert(self.mItemList, item)
    end
end

function clearItems(self)
    for i = 1, #self.mItemList do
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end

function deActive(self)
    super.deActive(self)
    self:clearItems()
end

return _M