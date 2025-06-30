--[[ 
-----------------------------------------------------
@filename       : DupChipSelectView
@Description    : 芯片掉落选择页面
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('dup.DupChipSelectView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('dupEquip/DupChipSelectView.prefab')
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(4585))--选择套装
end

--析构函数
function dtor(self)
end

function initData(self)
    self.mSuitDic = {}
    self.mSuitItemList = {}
    self.mSelectData = nil
    self.mSelectSuitId = 0
end

function configUI(self)
    self.mSuitItem = self:getChildGO("mSuitItem")
    self.mImgUsingTip = self:getChildGO("mImgUsingTip")
    self.mBtnDetermine = self:getChildGO("mBtnDetermine")
    self.mSuitContentTrans = self:getChildTrans("mSuitContent")
    self.mTxtIsUsing = self:getChildGO("mTxtIsUsing"):GetComponent(ty.Text)
    self.mTxtSuitName = self:getChildGO("mTxtSuitName"):GetComponent(ty.Text)
    self.mTxtSuitTitle = self:getChildGO("mTxtSuitTitle"):GetComponent(ty.Text)
    self.mSuitGroup = self:getChildGO("mSuitGroup"):GetComponent(ty.ScrollRect)
    self.mSuitContentRect = self:getChildGO("mSuitContent"):GetComponent(ty.RectTransform)
    self.mImgSuitInfoIcon = self:getChildGO("mImgSuitInfoIcon"):GetComponent(ty.AutoRefImage)
    
    self:setGuideTrans("guide_DupChipSelect_Info", self:getChildTrans("mInfoGroup"))
    self:setGuideTrans("guide_DupChipSelect_Suit", self:getChildTrans("mSuitGroup"))
end

--激活
function active(self, args)
    super.active(self, args)
    self.mSelectSuitId = dup.DupEquipBaseManager:getUsingSuitId()
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_CHIP_SELECT_SUIT, self.updateSuitState, self)
    self:updateView()
    self:updateSuitInfo()
    self:scrollLocation()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_CHIP_SELECT_SUIT, self.updateSuitState, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtSuitTitle.text = _TT(1316)--套装属性
end

--添加帧监听
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDetermine, self.onClickSelect)
end

--修改数据
function updateView(self)
    self:clearSuitItem()
    for i, suitId in ipairs(dup.DupEquipMainManager:getDupEquipSuitList()) do
        local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
        local suitItem = SimpleInsItem:create(self.mSuitItem, self.mSuitContentTrans, self.__cname .. "suitItem")
        suitItem:getChildGO("mImgSuitIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(suitConfigVo.icon), false)
        suitItem:getChildGO("mGroupChoice"):SetActive(false)
        suitItem:getChildGO("mGroupUse"):SetActive(false)
        suitItem:getChildGO("mTxtUse"):GetComponent(ty.Text).text = _TT(4586)--生效中
        suitItem:getChildGO("mTxtSuitName"):GetComponent(ty.Text).text = suitConfigVo.name
        suitItem:addUIEvent(nil, function()
            self.mSelectSuitId = suitId
            self:updateSuitInfo()
        end)
        self.mSuitDic[suitId] = suitItem
    end
end

function updateSuitInfo(self)
    self:clearSuitItemList()
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(self.mSelectSuitId)
    local suitList = {}
    if suitConfigVo then
        if suitConfigVo.suitSkillId_2 > 0 and suitConfigVo.suitSkillId_4 > 0 then
            suitList[1] = suitConfigVo.suitSkillId_2
            suitList[2] = suitConfigVo.suitSkillId_4
        elseif suitConfigVo.suitSkillId_4 > 0 then
            suitList[1] = suitConfigVo.suitSkillId_4
        elseif suitConfigVo.suitSkillId_2 > 0 then
            suitList[1] = suitConfigVo.suitSkillId_2
        end
        for i, vo in ipairs(suitList) do
            local skillVo = fight.SkillManager:getSkillRo(vo)
            local introduceItem = SimpleInsItem:create(self:getChildGO("mGroupSuit"), self:getChildTrans("mSuitInfoContent"), "DupChipSelectViewSuitInfoTxt")
            introduceItem:getChildGO("mTxtTitleSuit"):GetComponent(ty.Text).text = _TT(4036 + i)
            introduceItem:getChildGO("mTxtSuitDes"):GetComponent(ty.Text).text = skillVo:getDesc()
            table.insert(self.mSuitItemList, introduceItem)
        end
        self.mTxtSuitName.text = suitConfigVo.name
        self.mImgSuitInfoIcon:SetImg(UrlManager:getIconPath(suitConfigVo.icon), false)
        self:updateSuitState()
    end

end
--打开掉落详情界面
function onClickSelect(self)
    GameDispatcher:dispatchEvent(EventName.REQ_DUP_CHIP_SELECT_SUIT, self.mSelectSuitId)
end
--初始滚动定位
function scrollLocation(self)
    self:addTimer(0.1, 0.1, function()
        local curColl = math.ceil(table.keyof(dup.DupEquipMainManager:getDupEquipSuitList(), self.mSelectSuitId) / 4)
        local movePosY = 1 - (((curColl * 191) + (curColl * 10)) / self.mSuitContentTrans.rect.height)
        if curColl <= 1 then
            movePosY = 1
        end
        self.mSuitGroup.verticalNormalizedPosition = movePosY
    end)
end

function clearSuitItem(self)
    if self.mSuitDic then
        for i, item in pairs(self.mSuitDic) do
            item:poolRecover()
            item = nil
        end
        self.mSuitDic = {}
    end
end

function clearSuitItemList(self)
    if #self.mSuitItemList > 0 then
        for i, item in pairs(self.mSuitItemList) do
            item:poolRecover()
        end
        self.mSuitItemList = {}
    end
end
--有值修改使用，无值修改选择框
function updateSuitState(self)
    for suitId, suitItem in pairs(self.mSuitDic) do
        if dup.DupEquipBaseManager:getUsingSuitId() > 0 then
            suitItem:getChildGO("mGroupUse"):SetActive(dup.DupEquipBaseManager:getUsingSuitId() == suitId)
        end
        suitItem:getChildGO("mGroupChoice"):SetActive(self.mSelectSuitId == suitId)
    end
    self.mTxtIsUsing.text = self.mSelectSuitId == dup.DupEquipBaseManager:getUsingSuitId() and _TT(4586) or _TT(4587)
    self.mImgUsingTip:SetActive(self.mSelectSuitId == dup.DupEquipBaseManager:getUsingSuitId())
    self.mBtnDetermine:SetActive(self.mSelectSuitId ~= dup.DupEquipBaseManager:getUsingSuitId())
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]