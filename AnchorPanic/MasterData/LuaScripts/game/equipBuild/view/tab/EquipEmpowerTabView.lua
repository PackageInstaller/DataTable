module("equipBuild.EquipEmpowerTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("equipBuild/tab/EquipEmpowerTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mEquipVo = nil
    self.mEquipGrid = nil
    self.mAttrItemList = {}
end

function configUI(self)
    self.mEquipNode = self:getChildTrans("mEquipNode")
    self.mTextItemName = self:getChildGO("mTextItemName"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)

    self.mBtnTips = self:getChildGO("mBtnTips"):GetComponent(ty.Button)

    self.mEmptyState = self:getChildGO("mEmptyState")
    self.attrItem = self:getChildGO("attrItem")

    self.attrContent = self:getChildTrans("attrContent")

    self.mBtn_change = self:getChildGO("mBtn_change")

    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mTextTitle = self:getChildGO("mTextTitle"):GetComponent(ty.Text)

    self.infoGroup = self:getChildGO("infoGroup")
end



function addAllUIEvent(self)
    self:addUIEvent(self.mBtnTips, self.onBtnTipsClickHandler)
    self:addUIEvent(self.mBtn_change, self.onBtnChangeClickHandler)
end

function onBtnTipsClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_EMPOWER_TIPS_VIEW)
end

function initViewText(self)
    self.mTextTitle.text = _TT(71476)
    self.mTxtEmptyTip.text = _TT(71477)
    self:setBtnLabel(self.mBtn_change,71478,"重构")
end

function active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.GOLD_COIN_TID,MoneyTid.EQUIP_LOCK_TID, MoneyTid.EQUIP_EMPOWER_TID })
   GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_EMPOWER_INFO,self.showPanel,self)
    GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_EMPOWER_LOCK, self.updateEmpowerLock, self)
    self:showPanel()
end

function deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    GameDispatcher:removeEventListener(EventName.UPDATE_EQUIP_EMPOWER_INFO,self.showPanel,self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EQUIP_EMPOWER_LOCK, self.updateEmpowerLock, self)
    self:clearAttrItemList()
end

function updateEmpowerLock(self)
    local attachAttrList, attachAttrDic = self.selectEquipVo:getTuPoAttachAttr()
    local curLockNum = 0
    for i = 1, #attachAttrList, 1 do
        if attachAttrList[i].isLock then
            curLockNum = curLockNum + 1
        end
    end
    for i = 1,#self.mAttrItemList do
        self.mAttrItemList[i]:getChildGO("mImgLock"):SetActive(attachAttrList[i].isLock)
        self.mAttrItemList[i]:getChildGO("mImgUnLock"):SetActive(not attachAttrList[i].isLock)
        self.mAttrItemList[i]:getChildGO("StateButton"):SetActive(not(curLockNum == 2 and not attachAttrList[i].isLock))
    end
end

function showPanel(self)
    if self.selectEquipVo then
        self.selectEquipVo:removeEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA, self.updateViewInfo, self)
    end

    self.selectEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    self.selectEquipVo:addEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA, self.updateViewInfo, self)
    GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_EMPOWER_UNCONFIRM,{equipId = self.selectEquipVo.id})

    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end

    self.mEquipGrid = EquipGrid3:create(self.mEquipNode, self.selectEquipVo, 1)
    self.mEquipGrid:setClickEnable(false)
    self.mEquipGrid:setShowEquipStrengthenLvl(false)
    self.mEquipGrid:setIdxTap(false)

    
    local color = ""
    if self.selectEquipVo.color == 1 then
        color = "45cea2ff"
    elseif self.selectEquipVo.color == 2 then
        color = "29acffff"
    elseif self.selectEquipVo.color == 3 then
        color = "ff72f1ff"
    else
        color = "ff9e35ff"
    end
    self.mImgBar.color = gs.ColorUtil.GetColor(color)

    self.mTextItemName.text = self.selectEquipVo.name
    self.mTxtLv.text = self.selectEquipVo.strengthenLvl

    self:clearAttrItemList()
    local attachAttrList, attachAttrDic = self.selectEquipVo:getTuPoAttachAttr()
    local curLockNum = 0
    for i = 1, #attachAttrList, 1 do
        if attachAttrList[i].isLock then
            curLockNum = curLockNum + 1
        end
    end
    if attachAttrList and #attachAttrList >= 3 then
        for i = 1,#attachAttrList do
            local attachAttrVo = attachAttrList[i]
            local item = SimpleInsItem:create(self.attrItem, self.attrContent, "EquipEmpowerTab_attrItem")
            item:getChildGO("mTextDesc"):GetComponent(ty.Text).text =HtmlUtil:color(AttConst.getName(attachAttrVo.key), "feffff") .. HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "18ec68")
            item:getChildGO("mImgLock"):SetActive(attachAttrVo.isLock)
            item:getChildGO("mImgUnLock"):SetActive(not attachAttrVo.isLock)
          
            item:getChildGO("StateButton"):SetActive(not(curLockNum == 2 and not attachAttrVo.isLock))
            item:addUIEvent("StateButton",function ()
                self:onClickLock(i)
            end)
            table.insert(self.mAttrItemList, item)
        end
    end

    self.mEmptyState:SetActive(not (attachAttrList and #attachAttrList == 3))
    self.infoGroup:SetActive(attachAttrList and #attachAttrList == 3)
end

function onClickLock(self,index)
    local attachAttrList, attachAttrDic = self.selectEquipVo:getTuPoAttachAttr()
    local attachAttrVo = attachAttrList[index]

    if attachAttrVo.isLock then
        UIFactory:alertMessge(_TT(71486), true, function ()
            GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_EMPOWER_LOCK, {equipId = self.selectEquipVo.id, pos = index, isLock = 0})
        end)
    else    
        local curLockNum = 0
        for i = 1, #attachAttrList, 1 do
            if attachAttrList[i].isLock then
                curLockNum = curLockNum + 1
            end
        end
    
        if curLockNum == 2 then
            gs.Message.Show("不能全部锁定")
            return
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_EMPOWER_LOCK_SURE_PANEL,{equipId = self.selectEquipVo.id,pos = index,isLock = attachAttrVo.isLock and 0 or 1,type = 1})   
    end
    --GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_EMPOWER_LOCK,{equipId = self.selectEquipVo.id,pos = index,isLock = attachAttrVo.isLock and 0 or 1})
   
end

function onBtnChangeClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_EMPOWER_LOCK_SURE_PANEL,{equipId = self.selectEquipVo.id,type = 2})   
end

function clearAttrItemList(self)
    for i = 1, #self.mAttrItemList do
        self.mAttrItemList[i]:poolRecover() 
    end
    
    self.mAttrItemList = {}
end

return _M