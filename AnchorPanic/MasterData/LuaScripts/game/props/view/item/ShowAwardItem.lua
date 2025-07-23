--[[
-----------------------------------------------------
@filename       : ShowAwardItem
@Description    : 通用奖励展示item
@date           : 2021-03-29 17:20:03
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("ShowAwardItem", Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("reward/ShowAwardItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)
    self.mGrid = nil
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("mGroup"):GetComponent(ty.CanvasGroup)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clean()
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function setData(self, cusParent, propsVo)
    if cusParent then
        self:setParentTrans(cusParent, 0)
        self.parent = cusParent
    end
    
    self.propsVo = propsVo
    self:updateView()
end

function updateView(self)
    self:clean()
    if self.propsVo.type == PropsType.EQUIP then
        if self.propsVo.subType == PropsEquipSubType.SLOT_7 then
            self.mGrid = BraceletsGrid2:createByData({tid = self.propsVo.tid, num = self.propsVo.count, parent = self.mGroup.transform, isTween = true, showUseInTip = false, vo = self.propsVo})
        else
            self.mGrid = EquipGrid2:createByData({tid = self.propsVo.tid, num = self.propsVo.count, parent = self.mGroup.transform, isTween = true, showUseInTip = false, vo = self.propsVo})
        end
    else
        -- self.mGrid = PropsGrid:create(self.mGroup.transform, self.propsVo)
        self.mGrid = PropsGrid:createByData({tid = self.propsVo.tid, num = self.propsVo.count, parent = self.mGroup.transform, isTween = true, showUseInTip = false})

    end
    -- self.mGrid:setIsShowName(true)
    -- self.mGrid:setTween(true)
end

function clean(self)
    if (self.mGrid) then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end
end

function setAlpha(self, value)
    self.mGroup.alpha = value

    if value == 1 then
        self:showTween()
    end
end

function showTween(self)
    TweenFactory:scaleTo(self.mGroup.transform, gs.VEC3_ONE * 1.6, gs.VEC3_ONE, 0.1)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
