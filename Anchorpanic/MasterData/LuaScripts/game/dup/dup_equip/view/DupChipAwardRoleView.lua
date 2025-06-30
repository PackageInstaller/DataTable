--[[ 
-----------------------------------------------------
@filename       : DupChipAwardRoleView
@Description    : 芯片掉落规则页面
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('dup.DupChipAwardRoleView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('dupEquip/DupChipAwardRoleView.prefab')
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mAwardGridTrans = self:getChildTrans("mAwardGridTrans")
    self.mTxtTip = self:getChildGO('mTxtTip'):GetComponent(ty.Text)
    self.mTxtCurrent = self:getChildGO("mTxtCurrent"):GetComponent(ty.Text)
    self.mTxtRuleTips = self:getChildGO("mTxtRuleTips"):GetComponent(ty.Text)
end
--激活
function active(self, args)
    super.active(self, args)
    self.data = args.duplist
    self.mIndex = args.index
    self.mAwardItemList = {}
    self:updateAwardItem()
    GameDispatcher:addEventListener(EventName.ZERO_REFRESH, self.onUpadteZero, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.ZERO_REFRESH, self.onUpadteZero, self)
    self:clearItem()
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtRuleTips.text = _TT(4584)
end

--[[ 
零点刷新
]]
function onUpadteZero(self)
    self:clearItem()
    self:updateAwardItem()
end

--添加帧监听
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self:getChildGO("mBtnCloseView"), self.close)
end
--更新奖励预制体
function updateAwardItem(self)
    self.mAwardPropList = {}
    local curAwardDay = 0
    local clientTime = GameManager:getClientTime()
    local t = os.date('*t', clientTime)
    if t.wday == 1 then
        t.wday = 8
    end
    if t.hour < sysParam.SysParamManager:getValue(SysParamType.DUPCHIP_REFRESH) then
        curAwardDay = t.wday - 1
        if curAwardDay <= 1 then
            curAwardDay = 8
        end
    else
        curAwardDay = t.wday
    end
    local awardList = {}

    for l, vo in ipairs(self.data) do
        for n = 1, 7 do
            if l == self.mIndex then
                table.insert(awardList, vo:getCurrentShowDrop(n))
            end
        end
    end
    for m, vo1 in ipairs(awardList) do
        local item = SimpleInsItem:create(self:getChildGO("mGroupAwardItem"), self.mAwardContent, "RoleAwardItem")
        item:getChildGO("mTxtWeek"):GetComponent(ty.Text).text = self:updateTxt(m)
        if #vo1 - 1 > 8 then
            item:getChildGO("mBtnNextAward"):SetActive(true)
        end
        item:getChildGO("mTxtCurrent"):GetComponent(ty.Text).text = _TT(1108)
        item:getChildGO("mCurrent"):SetActive(m == (curAwardDay - 1))
        for k, vo2 in ipairs(vo1) do
            if k ~= #vo1 then
                local propVo = props.PropsManager:getPropsVo({ tid = vo2.tid, num = vo2.num })
                local prop
                if #vo1 - 1 > 8 then
                    self:getChildGO("mScrollView"):SetActive(true)
                    prop = PropsGrid:create(item:getChildTrans("mAwardTrans"), propVo, 1)
                else
                    self:getChildGO("mScrollView"):SetActive(false)
                    prop = PropsGrid:create(item:getChildTrans("mAwardTrans1"), propVo, 1)
                end
                table.insert(self.mAwardPropList, prop)
            end
        end
        self.mAwardItemList[m] = item
    end
end
--删除奖励预制体
function clearItem(self)
    if #self.mAwardItemList > 0 then
        for k, v in pairs(self.mAwardItemList) do
            if v then
                v:poolRecover()
                v = nil
            end
        end
        self.mAwardItemList = {}
    end
    if #self.mAwardPropList > 0 then
        for z, y in pairs(self.mAwardPropList) do
            if y then
                y:poolRecover()
                y = nil
            end
        end
        self.mAwardPropList = {}
    end
end
--阿拉伯转中文
function updateTxt(self, curNum)
    local zhTxtDec = { _TT(53613), _TT(53614), _TT(53615), _TT(53616), _TT(53617), _TT(53618), _TT(53619), _TT(53623), _TT(53624) }
    for i, v in ipairs(zhTxtDec) do
        if i == curNum then
            return v
        end
    end

end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(53624):	"九"
	语言包: _TT(53623):	"八"
	语言包: _TT(53622):	"七"
	语言包: _TT(53618):	"六"
	语言包: _TT(53617):	"五"
	语言包: _TT(53616):	"四"
	语言包: _TT(53615):	"三"
	语言包: _TT(53614):	"二"
	语言包: _TT(53613):	"一"
]]