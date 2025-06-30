module("cycle.CyclePostwarItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CyclePostwarItem.prefab")

mTypeDicEVENT_CHANGE = "EVENT_CHANGE"

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mBtnClick = self:getChildGO("mBtnClick")
    self.mType = self:getChildGO("mType")
    self.mType1 = self:getChildGO("mType1")
    self.mImgRecuit = self:getChildGO("mImgRecuit"):GetComponent(ty.AutoRefImage)
    self.mTxtTicket = self:getChildGO("mTxtTicket"):GetComponent(ty.Text)
    self.mTxtDesTicket = self:getChildGO("mTxtDesTicket"):GetComponent(ty.Text)
    self.mType2 = self:getChildGO("mType2")
    self.mImgCollage = self:getChildGO("mImgCollage"):GetComponent(ty.AutoRefImage)
    self.mTxtCollage = self:getChildGO("mTxtCollage"):GetComponent(ty.Text)
    self.mTxtDesCollage = self:getChildGO("mTxtDesCollage"):GetComponent(ty.Text)
    self.mType3 = self:getChildGO("mType3")
    self.mImgCoin = self:getChildGO("mImgCoin"):GetComponent(ty.AutoRefImage)
    self.mTxtCoin = self:getChildGO("mTxtCoin"):GetComponent(ty.Text)
    self.mTxtDesCoin = self:getChildGO("mTxtDesCoin"):GetComponent(ty.Text)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnImg = self.mBtnGet:GetComponent(ty.Image)
    self.mTxtBtn = self:getChildGO("mTxtBtn"):GetComponent(ty.Text)
    self.mAni = self.UIObject:GetComponent(ty.Animator)

    self.mIsNotHas = self:getChildGO("mIsNotHas")
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.m_childGos["mTxtNotHas"]:GetComponent(ty.Text).text = _TT(77856)
    self.mTypeDic = {}
    self.mTypeDic[1] = self.mType1
    self.mTypeDic[2] = self.mType2
    self.mTypeDic[3] = self.mType3
    self:addUIEvent(self.mBtnClick, self.onBtnClick)
    self:addUIEvent(self.mBtnGet, self.onBtnClick)
end

function active(self)
    super.active(self)
    self.mAni:SetTrigger("enter")

end

function deActive(self)
    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData
    self:updateView()
end

function updateView(self)
    self.mIsNotHas:SetActive(false)
    for k, v in pairs(self.mTypeDic) do
        -- self.isUsed = self.mData.is_used == 1
        self.type = self.mData.args[1]
        self.value = self.mData.args[2]
        v:SetActive(self.type == k)

        if self.type == k then
            self.mTxtBtn.color = gs.ColorUtil.GetColor("202226ff")
            if self.type == POSTWAR_TYPE.QUIT then
            elseif self.type == POSTWAR_TYPE.RECUIT then
                self.mTxtBtn.text = _TT(27531)
                self.mTxtBtn.color = gs.ColorUtil.GetColor("ffffffff")
                self.mBtnImg.color = gs.ColorUtil.GetColor("0057ffff")
            elseif self.type == POSTWAR_TYPE.COLLAGE then
                self.mTxtBtn.text = _TT(27532)
                self.mBtnImg.color = gs.ColorUtil.GetColor("d3e5f6ff")
            elseif self.type == POSTWAR_TYPE.CON then
                self.mTxtBtn.text = _TT(27533)
                self.mBtnImg.color = gs.ColorUtil.GetColor("ffb644ff")
            end
        end
        self.mType:SetActive(false)
        self.mBtnGet:SetActive(true)
    end

    if self.type == POSTWAR_TYPE.RECUIT then
        local recVo = cycle.CycleManager:getCycleRecruitData(self.value)
        self.mImgRecuit:SetImg(UrlManager:getIconPath(recVo.icon), false)
        self.mTxtTicket.text = _TT(recVo.name)
        self.mTxtDesTicket.text = _TT(recVo.des)
    elseif self.type == POSTWAR_TYPE.COLLAGE then
        local collageVo = cycle.CycleManager:getCycleCollectionDataById(self.value)
        self.mImgCollage:SetImg(UrlManager:getCycelCollectionIcon(collageVo.icon),false)
        self.mTxtCollage.text = _TT(collageVo.name)
        self.mTxtDesCollage.text = _TT(collageVo.des2)
        self.mIsNotHas:SetActive(not cycle.CycleManager:getCycleCollageCanHas(self.value) and not self.isUsed)
        if collageVo.eleType == -1 then
            self.mImgEleType.gameObject:SetActive(false)
        else
            self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(collageVo.eleType), false)
            self.mImgEleType.gameObject:SetActive(true)
        end    

    elseif self.type == POSTWAR_TYPE.CON then
        self.mTxtCoin.text = _TT(27605)
        self.mTxtDesCoin.text = _TT(77817, self.value)
    end
end


function onBtnClick(self)
    if cycle.CycleManager:getPostwarClicked() == false then
        local currentCellId = cycle.CycleManager:getCurrentCell()
        if self.type == POSTWAR_TYPE.RECUIT then
            cycle.CycleManager:setCurTicketAndType(self.value, RECUIT_TYPE.POSTWAR)
            -- self.mAni:SetTrigger("exit")
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_HERO_SELECT_PANEL)
        else
            self.mAni:SetTrigger("exit")
            LoopManager:addTimer(0.3, 1, self, function() 
                GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
                    cellId = currentCellId,
                    args = {self.type, self.value}
                })
            end)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27605):	"玩法币"
	语言包: _TT(27534):	"已经被使用了 不要重复获取"
	语言包: _TT(27533):	"取走"
	语言包: _TT(27532):	"取下"
	语言包: _TT(27531):	"招募"
]]
