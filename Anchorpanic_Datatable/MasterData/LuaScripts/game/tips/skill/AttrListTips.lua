--[[ 
-----------------------------------------------------
@filename       : AttrListTips
@Description    : 属性列表通用tips
-----------------------------------------------------
]]
module("tips.AttrListTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/AttrListTips.prefab")

isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 初始化数据
function initData(self)
    self.mItemH = nil
    self.mShowCount = 4
    self.mDataList = nil
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.m_scrollGo = self:getChildGO("LyScroller")
    self.m_scrollRect = self.m_scrollGo:GetComponent(ty.RectTransform)
    self.m_scroll = self.m_scrollGo:GetComponent(ty.LyScroller)
    self.m_scroll:SetItemRender(tips.AttrListTipsItem)

    self.mItemH = self:getChildGO('LyScrollerItem'):GetComponent(ty.RectTransform).sizeDelta.y
end

function active(self, args)
    super.active(self, args)
    
    self.mDataList = args.attrVoList
    self:__updateView()
end

--非激活
function deActive(self)
    super.deActive(self)

    if(self.mDataList)then
        for i = 1, #self.mDataList do
            self.mDataList[i].AttrListTipsItemIndex = nil
        end
        self.mDataList = nil
    end
end

function initViewText(self)
    super.initViewText(self)
end

function __updateView(self)
    local count = #self.mDataList
    gs.TransQuick:SizeDelta02(self.m_scrollRect, math.min(self.mShowCount, count) * (self.mItemH or 100))
    
    for i = 1, count do
        self.mDataList[i].AttrListTipsItemIndex = i
    end
    if (self.m_scroll.Count <= 0) then
        self.m_scroll.DataProvider = self.mDataList
    else
        self.m_scroll:ReplaceAllDataProvider(attrself.mDataListList)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
