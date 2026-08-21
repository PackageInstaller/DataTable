--[[ 
-----------------------------------------------------
@filename       : FuncTipsView
@Description    : 功能说明
@date           : 2021-02-22 14:11:08
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.funcTips.view.FuncTipsView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("funcTips/FuncTipsView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemList = {}
    self.mMaskList = {}
end

--只适配按钮
function getAdaptaTrans(self)
    return self:getChildTrans("mGroupBtnClose")
end

-- 初始化
function configUI(self)
    self.mImgMask = self:getChildGO("mImgMask")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupTips = self:getChildGO("mGroupTips")
    self.mImgMaskBg1 = self:getChildGO("mImgMaskBg1")
    self.mImgMaskBg2 = self:getChildGO("mImgMaskBg2")
    self.mTipsItem = self:getChildGO("GroupTipsItem")
    self.mImgTipsBg = self:getChildTrans("mImgTipsBg")
    self.mGroupMask = self:getChildTrans("mGroupMask")
    self.mGroupArea = self:getChildTrans("mGroupArea")
    self.mTipsItem2 = self:getChildGO("GroupTipsItem2")
    self.mImgTipsBg2 = self:getChildTrans("mImgTipsBg2")
    self.mGroupArea2 = self:getChildTrans("mGroupArea2")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtTips2 = self:getChildGO("mTxtTips2"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mId = args.id
    if gs.CameraMgr:GetUICamera().orthographic == false then
        -- 兼容开启透视的页面，延时获取正确坐标和宽高
        gs.CameraMgr:SetUICameraProjetion(false, 2)
        self:setTimeout(0.1, function()
            self:updateView()
        end)
    else
        -- 正常流程
        self:updateView()
    end
    GameDispatcher:addEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
    self:setAdapta()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
    LoopManager:removeFrame(self, self.step)

    if gs.CameraMgr:GetUICamera().orthographic == false then
        gs.CameraMgr:SetUICameraProjetion(true, 2)
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mImgMaskBg1, self.onRetrun)
    -- self:addUIEvent(self.mBtnCreate, self.onCreate)
    self:addUIEvent(self.mBtnClose, self.close)
end

function updateView(self)
    self:recoverItem()
    local list = funcTips.FuncTipsManager:getData(self.mId)
    if list == nil then
        logError(string.format("TipsUiCode%s没有配置，找策划哥", self.mId))
        return
    end

    for i, vo in ipairs(list) do
        local item = SimpleInsItem:create(self:getChildGO("GroupAreaItem"), self.mGroupArea, "FuncTipsAreaItem")
        local itemTrans = item:getTrans()

        local targetTrans = guide.GuideUITransHandler:getTrans(vo.control)
        if not targetTrans then
            return
        end
        local targetW = targetTrans.rect.width
        local targetH = targetTrans.rect.height
        local targetPos = gs.TransQuick:RTransCenterV3(targetTrans)
        local retPos = self.mGroupArea:InverseTransformPoint(targetPos)

        gs.TransQuick:SizeDelta(itemTrans, targetW, targetH)
        gs.TransQuick:LPos(itemTrans, retPos.x, retPos.y, 0)


        local icon = item:getChildTrans("mImgIcon")
        if vo.type == 1 then
            gs.TransQuick:Anchor(icon, 0, 1, 0, 1)
            gs.TransQuick:UIPos(icon, math.abs(icon.anchoredPosition.x), -math.abs(icon.anchoredPosition.y))
        elseif vo.type == 2 then
            gs.TransQuick:Anchor(icon, 0, 0, 0, 0)
            gs.TransQuick:UIPos(icon, math.abs(icon.anchoredPosition.x), math.abs(icon.anchoredPosition.y))
        elseif vo.type == 3 then
            gs.TransQuick:Anchor(icon, 1, 0, 1, 0)
            gs.TransQuick:UIPos(icon, -math.abs(icon.anchoredPosition.x), math.abs(icon.anchoredPosition.y))
        elseif vo.type == 4 then
            gs.TransQuick:Anchor(icon, 1, 1, 1, 1)
            gs.TransQuick:UIPos(icon, -math.abs(icon.anchoredPosition.x), -math.abs(icon.anchoredPosition.y))
        end

        item:addUIEvent("mGroupBtn", function()
            self:onShowTips(i, item)
        end)
        table.insert(self.mItemList, item)

        local mask = SimpleInsItem:create(self:getChildGO("ImgMaskItem"), self.mGroupMask, "FuncTipsMaskItem")

        gs.TransQuick:SizeDelta(mask:getTrans(), targetW, targetH)
        gs.TransQuick:LPos(mask:getTrans(), retPos.x, retPos.y, 0)

        table.insert(self.mMaskList, mask)
    end
end

-- 回收项
function recoverItem(self)
    if self.mItemList then
        for i, v in pairs(self.mItemList) do
            v:poolRecover()
        end
    end
    self.mItemList = {}

    if self.mMaskList then
        for i, v in pairs(self.mMaskList) do
            v:poolRecover()
        end
    end
    self.mMaskList = {}
end

function onRetrun(self)
    self.mImgMaskBg2:SetActive(false)
    self.mGroupTips:SetActive(false)
    for i = 1, #self.mMaskList do
        self.mMaskList[i]:setActive(true)
    end
end

function onShowTips(self, index, item)
    self.mImgMaskBg2:SetActive(true)
    self.mGroupTips:SetActive(true)

    for i = 1, #self.mMaskList do
        if index == i then
            self.mMaskList[i]:setActive(true)
            self.mItemList[i]:addOnParent(self.mGroupArea2)
        else
            self.mMaskList[i]:setActive(false)
            self.mItemList[i]:addOnParent(self.mGroupArea)
        end
    end
    local list = funcTips.FuncTipsManager:getData(self.mId)
    local vo = list[index]

    local item = self.mItemList[index]

    local icon = item:getChildGO("mImgIcon")
    local pos = self.mGroupArea2:InverseTransformPoint(icon.transform.position)

    if vo.type == 1 then
        self.mTxtTips.text = vo:getExplain()
        self.mTipsItem:SetActive(true)
        self.mTipsItem2:SetActive(false)
        gs.TransQuick:LPos(self.mTipsItem.transform, pos.x - 15, pos.y, 0)
        gs.TransQuick:Pivot(self.mImgTipsBg, 0.5, 1)
    elseif vo.type == 2 then
        self.mTxtTips.text = vo:getExplain()
        self.mTipsItem:SetActive(true)
        self.mTipsItem2:SetActive(false)
        gs.TransQuick:LPos(self.mTipsItem.transform, pos.x - 15, pos.y, 0)
        gs.TransQuick:Pivot(self.mImgTipsBg, 0.5, 0)
        self.mTxtTips2.text = vo:getExplain()
    elseif vo.type == 3 then
        self.mTxtTips2.text = vo:getExplain()
        self.mTipsItem:SetActive(false)
        self.mTipsItem2:SetActive(true)
        gs.TransQuick:Pivot(self.mImgTipsBg2, 0.5, 0)
        gs.TransQuick:LPos(self.mTipsItem2.transform, pos.x + 15, pos.y, 0)
    elseif vo.type == 4 then
        self.mTxtTips2.text = vo:getExplain()
        self.mTipsItem:SetActive(false)
        self.mTipsItem2:SetActive(true)
        gs.TransQuick:Pivot(self.mImgTipsBg2, 0.5, 1)
        gs.TransQuick:LPos(self.mTipsItem2.transform, pos.x + 15, pos.y, 0)
    end

    self.mTxtTips:GetComponent(ty.ContentSizeFitter):SetLayoutVertical()
    self.mTxtTips2:GetComponent(ty.ContentSizeFitter):SetLayoutVertical()
    gs.LayoutRebuilder:ForceRebuildLayoutImmediate(self.mTxtTips.transform)
    gs.LayoutRebuilder:ForceRebuildLayoutImmediate(self.mTxtTips2.transform)
    gs.LayoutRebuilder:ForceRebuildLayoutImmediate(self.mImgTipsBg)
    gs.LayoutRebuilder:ForceRebuildLayoutImmediate(self.mImgTipsBg2)
end

-- ------------------------------------------------
-- function onCreate(self)
--     self:recoverItem()
--     self.mImgMaskBg2:SetActive(false)
--     self.mGroupCreate.gameObject:SetActive(true)
--     self.createItem = SimpleInsItem:create(self:getChildGO("GroupAreaItem"), self:getChildTrans("mGroupCreateArea"), "FuncTipsAreaItem")
--     gs.TransQuick:SizeDelta(self.createItem:getTrans(), 100, 100)
--     gs.TransQuick:UIPos(self.createItem:getTrans(), 700, -300, 0)
--     local pos = self.createItem:getTrans().anchoredPosition
--     local size = self.createItem:getTrans().sizeDelta
--     self:getChildGO("mInputX"):GetComponent(ty.InputField).text = pos.x
--     self:getChildGO("mInputY"):GetComponent(ty.InputField).text = pos.y
--     self:getChildGO("mInputW"):GetComponent(ty.InputField).text = size.x
--     self:getChildGO("mInputH"):GetComponent(ty.InputField).text = size.y
--     LoopManager:addFrame(1, 0, self, self.step)
-- end
-- function step(self)
--     gs.TransQuick:SizeDelta(self.createItem:getTrans(), self:getChildGO("mInputW"):GetComponent(ty.InputField).text, self:getChildGO("mInputH"):GetComponent(ty.InputField).text)
--     gs.TransQuick:UIPos(self.createItem:getTrans(), self:getChildGO("mInputX"):GetComponent(ty.InputField).text, self:getChildGO("mInputY"):GetComponent(ty.InputField).text, 0)
-- end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]