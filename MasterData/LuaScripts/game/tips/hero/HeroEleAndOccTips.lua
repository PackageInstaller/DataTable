module("tips.HeroEleAndOccTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/HeroEleAndOccTips.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 -- 是否
isAddMask = 0
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
    self.mItemList = {}
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mBtnOcc = self:getChildGO("mBtnOcc")
    self.mBtnEle = self:getChildGO("mBtnEle")
    self.mImgOcc = self:getChildGO("mImgOcc")
    self.mImgEle = self:getChildGO("mImgEle")
    self.mImgItem = self:getChildGO("mImgItem")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mScrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    self.mContent = self.mScrollRect.content
end

function initViewText(self)
    --self:setBtnLabel(self.mBtnEle, 1030, "属性")
    --self:setBtnLabel(self.mBtnOcc, 1007, "职业")
end

function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, self.onClose)
    self:addUIEvent(self.mBtnOcc, self.onClickHideHandler, nil, 1)
    self:addUIEvent(self.mBtnEle, self.onClickHideHandler, nil, 2)
end

function active(self, args)
    super.active(self, args)
end

function open(self, args)
    super.open(self, args)
    self:onClickHideHandler(args.type)
    --local pos = self.UITrans:TransformPoint(args.parent.transform.localPosition)
    --logInfo("世界坐标"..pos[1])
    --  self.UITrans:SetParent(args.parent, false)
end

function deActive(self)
    super.deActive(self)
end

function updateView(self, type)
    self:recoverItems()
    local list = hero.HeroManager:getOccAndEleConfigList(type)
    for _, vo in ipairs(list) do
        local item = SimpleInsItem:create(self.mImgItem, self.mContent, "HeroEleAndOccTipsOccOrEle")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = vo:getName()
        item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = vo:getExplin()
        item:getChildGO("mIcon"):GetComponent(ty.AutoRefImage):SetImg(vo:getIcon(), true)
        table.insert(self.mItemList, item)
    end
    self.mScrollRect.verticalNormalizedPosition = 1
end

function onClickHideHandler(self, type)
    self.mImgOcc:SetActive(type == 1)
    self.mImgEle:SetActive(type == 2)
    local colorEle = (type == 2) and "FFFFFFff" or "82898cff"
    local colorOcc = (type == 1) and "FFFFFFff" or "82898cff"
    self:setBtnLabel(self.mBtnEle, -1, HtmlUtil:color("属性", colorEle))
    self:setBtnLabel(self.mBtnOcc, -1, HtmlUtil:color("职业", colorOcc))
    self:updateView(type)
end

function onClose(self)
    super.onClickClose(self)
end

function recoverItems(self)
    if #self.mItemList > 0 then
        for _, item in ipairs(self.mItemList) do
            item:poolRecover()
            item = nil
        end
        self.mItemList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(36):	"效果"
]]