--[[ 
-----------------------------------------------------
@filename       : CovenantTalentGeneItem
@Description    : 战盟天赋item
@date           : 2021-06-17 10:09:03
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.view.item.CovenantTalentGeneItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenantTalent/CovenantTalentItem.prefab")

-- 选中展示
EVENT_SHOW_TALENT = "EVENT_SHOW_TALENT"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

-- 初始化
function configUI(self)

    self.mImgSelect = self:getChildGO("mImgSelect")

    self.mImgBgGo = self:getChildGO("mImgBg")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgCanActGo = self:getChildGO("mImgCanAct")
    self.mImgCanAct = self:getChildGO("mImgCanAct"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgEff = self:getChildGO("mImgEff"):GetComponent(ty.AutoRefImage)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mImgBgGo, self.onClick)
end


function onClick(self)
    -- GameDispatcher:dispatchEvent(EventName.SHOW_COVENANT_TALENT_INFO, self:getData().dupId)
    self:dispatchEvent(self.EVENT_SHOW_TALENT, self:getData())
end

-- 设置数据
function setData(self, cusParent, cusHelperId, covenantTalentBaseVo)
    self:setParentTrans(cusParent)

    self.helperId = cusHelperId
    self.data = covenantTalentBaseVo

    self.mImgCanActGo:SetActive(false)
    self.geneData = covenantTalent.CovenantTalentManager:getGeneData(self.helperId, self.data.id)
    if covenantTalent.CovenantTalentManager:isOrderType(self.data.type) then
        -- 凹槽
        self.mTxtLv.text = ""
        self.mImgEff.gameObject:SetActive(true)
        -- self.mImgEff:SetImg(UrlManager:getPackPath(string.format("covenantTalent/covenantTalent_type_%s_%s.png", self.data.type, 1)), false)
        if self.geneData and self.geneData.isActive == 1 then
            self.mImgBg:SetImg(UrlManager:getPackPath("covenantTalent/covenantTalent_10.png"), true)
            self.mImgEff:SetImg(UrlManager:getPackPath(string.format("covenantTalent/covenantTalent_type_%s_%s.png", self.data.type, 2)), false)
            self.mImgIcon:GetComponent(ty.CanvasGroup).alpha = 1
        else
            self.mImgBg:SetImg(UrlManager:getPackPath("covenantTalent/covenantTalent_12.png"), true)
            self.mImgEff:SetImg(UrlManager:getPackPath(string.format("covenantTalent/covenantTalent_type_%s_%s.png", self.data.type, 1)), false)
            self.mImgIcon:GetComponent(ty.CanvasGroup).alpha = 0.3
        end

        if self.geneData and self:isCanActive() then
            self.mImgCanAct:SetImg(UrlManager:getPackPath("covenantTalent/covenantTalent_15.png"), true)
            self.mImgCanActGo:SetActive(true)
        end

        if self.geneData and self.geneData.orderVo then
            self.mImgIcon.gameObject:SetActive(true)
            self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.geneData.orderVo.tid), false)
        else
            self.mImgIcon.gameObject:SetActive(false)
        end

    else
        -- 基因
        if self.geneData and self.geneData.isActive == 1 then
            self.mImgBg:SetImg(UrlManager:getPackPath("covenantTalent/covenantTalent_9.png"), true)
            self.mImgIcon:GetComponent(ty.CanvasGroup).alpha = 1
        else
            self.mImgBg:SetImg(UrlManager:getPackPath("covenantTalent/covenantTalent_11.png"), true)
            self.mImgIcon:GetComponent(ty.CanvasGroup).alpha = 0.3
        end

        if self.geneData and self:isCanActive() then
            self.mImgCanAct:SetImg(UrlManager:getPackPath("covenantTalent/covenantTalent_14.png"), true)
            self.mImgCanActGo:SetActive(true)
        end

        self.mImgEff.gameObject:SetActive(false)

        if self.geneData and self.geneData.isUnLock == 1 then
            local maxLvl = covenantTalent.CovenantTalentManager:getGeneMaxLvl(self.helperId, self.data.id)
            self.mTxtLv.text = string.substitute("{0}/{1}", self.geneData.lvl, maxLvl)

            self.mImgIcon.gameObject:SetActive(true)
            self.mImgIcon:SetImg(UrlManager:getIconPath(string.format("equipSuit/equipSuitIcon/equip_suit_icon_%s.png", math.ceil(self.data.id % 8) + 1)), false)
        else
            self.mTxtLv.text = ""
            self.mImgIcon.gameObject:SetActive(false)
        end
    end
    self:updateStyle()
end

function updateStyle(self)
    local style = self.data.style
    self.mGroupLine = self:getChildGO(string.format("mGroupLine%s", style))
    self.mGroupLine:SetActive(true)

    local isActive = false
    if self.geneData then
        isActive = self.geneData.isActive == 1
    end
    self:getChildGO(string.format("mLine_%s_1", style)):SetActive(not isActive)
    self:getChildGO(string.format("mLine_%s_2", style)):SetActive(isActive)
end

function isCanActive(self)
    local isCan = false
    for i, v in ipairs(self.data.preIds) do
        local data = covenantTalent.CovenantTalentManager:getGeneData(self.helperId, v)
        if data and data.isActive == 1 then
            isCan = true
        end
    end
    local list = covenantTalent.CovenantTalentManager:getTalentColData(self.helperId)[self.data.mutex]
    for i, v in ipairs(list) do
        local data = covenantTalent.CovenantTalentManager:getGeneData(self.helperId, v.id)
        if data and data.isActive == 1 then
            isCan = false
        end
    end
    return isCan
end


function getData(self)
    return self.data
end

function setSelectState(self, value)
    self.mImgSelect:SetActive(value)
end

function poolRecover(self)
    super.poolRecover(self)
    self.mGroupLine:SetActive(false)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
