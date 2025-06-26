--[[ 
-----------------------------------------------------
@filename       : RogueLikeFightInfoPanel
@Description    : 肉鸽战斗详情界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("rogueLike.RogueLikeFightInfoPanel", Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeFightInfoPanel.prefab")

-- destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
-- panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mAwardList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    -- self.mBtnFight = self:getChildGO("mBtnFight")
    -- self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)

    self.mTxtAwardTitle = self:getChildGO("TextAwardTitle"):GetComponent(ty.Text)
    self.mTxtStageId = self:getChildGO("TextStageId"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("TextStageName"):GetComponent(ty.Text)
    self.mTxtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("Scroller"):GetComponent(ty.ScrollRect)
    self.mScrollContent = self.mScroller.content
    -- self.mGoReceiveSign = self:getChildGO("ReceiveSign")
    -- self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    -- self.mTxtCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mMoneyBarTrans = self:getChildTrans("mMoneyBarTrans")
    self.mRectDetail = self:getChildGO("GroupDetail"):GetComponent(ty.RectTransform)
    -- self.mImgPreview = self:getChildGO("ImgPreview"):GetComponent(ty.AutoRefImage)
    -- self.mImgBorder = self:getChildGO("ImgBorder"):GetComponent(ty.AutoRefImage)
    self.mImgToucher = self:getChildGO("mImgToucher")
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.ani = self.UIObject:GetComponent(ty.Animator)
end

function show(self, args, parent)
    self:setParentTrans(parent)
    self:showViewAni()
    if not self.mMoneyBarItem then
        self.mMoneyBarItem = MoneyItem:poolGet()
    end
    self.mMoneyBarItem:setData(self.mMoneyBarTrans, { tid = MoneyTid.FUNCTION_TID, frontType = 2 })
    -- super.active(self, args)
    self.id = args.id
    self.eventId = args.eventId
    self.args = args.args

    self.dupId = args.args[1].key
    self:showInfoPanel()
    self:addOnClick(self.mBtnFight, self.onFightClick)
    self:addOnClick(self.mBtnClose, self.closeView)
end

--非激活
function deActive(self)
    if self.mMoneyBarItem then
        self.mMoneyBarItem:poolRecover()
        self.mMoneyBarItem = nil
    end
end

-- -- -- 激活
-- -- function active(self, args)
-- --     super.active(self, args)
-- --     self.id = args.id
-- --     self.eventId = args.eventId
-- --     self.args = args.args

-- --     self.dupId = args.args[1].key
-- --     self:showInfoPanel()
-- --     -- self.mTxtInfo.text = "这里是展示了 ID="..args.id.."的内容"
-- -- end

-- -- 反激活（销毁工作）
-- -- function deActive(self)
-- --     super.deActive(self)

-- --     self:clearItems()
-- -- end

-- --[[ 
--     初始化界面的静态文本，图片字
--     每次打开界面都会重新读取，多语言切换时可以及时更新
-- ]]
-- function initViewText(self)
--     -- self:setBtnLabel(self.aa, 10001, "按钮")
-- end

-- -- 为组件加入侦听点击事件
-- function addUIEvent(self, obj, callBack, soundPath, ...)
--     self:addOnClick(obj, callBack, soundPath, ...)

--     self.uiEventList = self.uiEventList or {}
--     table.insert(self.uiEventList, obj)
-- end

-- -- UI事件管理(关闭界面会自动移除)
-- function addAllUIEvent(self)

--     --self:addUIEvent(self.mImgToucher, self.onClickClose)
-- end

function showInfoPanel(self)
    self.mInfoVo = rogueLike.RogueLikeManager:getRogueLikeDupData(self.dupId)
    --self.mTxtStageId.text = self.mInfoVo.dupId
    self.mTxtStageName.text = _TT(self.mInfoVo.name)
    self.mTxtStageDes.text = _TT(self.mInfoVo.des)
    self:clearItems()
    local awardList = AwardPackManager:getAwardListById(self.mInfoVo.showAwardId)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num })
        table.insert(self.mAwardList, propsGrid)
    end

    rogueLike.RogueLikeManager:setLastMapPowerFight(self.mInfoVo.recommandFight)
    -- local maxPower = rogueLike.RogueLikeManager:getTeamPower()
    -- if maxPower > self.mInfoVo.recommandFight then
    --     self.mTxtStageDes.text = "敌方战力:" .. self.mInfoVo.recommandFight .. "\n" .. "我方战力:<color=#03950dff>" .. maxPower .. "</color>"
    -- else
    --     self.mTxtStageDes.text = "敌方战力:" .. self.mInfoVo.recommandFight .. "\n" .. "我方战力:<color=#d53529ff>" .. maxPower .. "</color>"
    -- end

    -- self.mTxtStageDes.text = self.mInfoVo.

end

function clearItems(self)
    if (self.mAwardList) then
        for i = #self.mAwardList, 1, -1 do
            local item = self.mAwardList[i]
            item:poolRecover()
        end
    end
    self.mAwardList = {}
end

function closeView(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_INFINITE_CITY_DUP_INFO_VIEW)
end

function onFightClick(self)
    self:hideViewAni()
    formation.checkFormationFight(PreFightBattleType.RogueLike, DupType.RogueLike, self.id, formation.TYPE.ROGUELIKE, nil, nil)
end

function showViewAni(self)
    self.ani:SetTrigger("show")
end

function hideViewAni(self)
    self.ani:SetTrigger("exit")
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]