--[[ 
    爬塔副本区域item
    @autor Jacob 
]]
module('dup.DupClimbTowerDeepAreaItem', Class.impl(BaseComponent))

DayTypeStr = {"一", "二", "三", "四", "五", "六", "日"}

function __getPrefabName(self)
    return UrlManager:getUIPrefabPath('domainSurvey/DomainSurveyDeepItem.prefab')
end

function __initGo(self)
    self.mItemName = self:getChildGO("mItemName"):GetComponent(ty.Text)

    self.mNormal = self:getChildGO("mNormal")
    self.mLock = self:getChildGO("mLock")
    self.mComplete = self:getChildGO("mComplete")

    -- self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTxtProNum = self:getChildGO("mTxtProNum"):GetComponent(ty.Text)
    self.mTxt_01 = self:getChildGO("mTxt_01"):GetComponent(ty.Text)
    self.mTxtOpenDate = self:getChildGO("mTxtOpenDate"):GetComponent(ty.Text)
    self.mTxtPersent = self:getChildGO("mTxtPersent")
    self.mTxtDup = self:getChildGO("mTxtDup")
    self.mIcon = self:getChildGO("mIcon"):GetComponent(ty.AutoRefImage)
    self.mIconComplete = self:getChildGO("mIconComplete"):GetComponent(ty.AutoRefImage)
    self.mIconLock = self:getChildGO("mIconLock"):GetComponent(ty.AutoRefImage)
    self.mImgProcess = self:getChildGO("mImgProcess"):GetComponent(ty.Image)
end

function getAreaVo(self)
    return self:getData().areaVo
end

function __updateCustomView(self)
    self:updateView()
end

function updateView(self)
    -- Lock
    local passCount,allCount,persent = dup.DupClimbTowerManager:getDeepProgressByAreaId(self:getAreaVo().id)
    self.mIcon:SetImg(UrlManager:getIconPath(self:getAreaVo().icon))
    self.mIconComplete:SetImg(UrlManager:getIconPath(self:getAreaVo().icon))
    self.mIconLock:SetImg(UrlManager:getIconPath(self:getAreaVo().icon))
    self.mNormal:SetActive(true)
    -- self.mImgProgress.fillAmount = persent
    local txt = ""
    if(passCount < allCount) then 
        txt = "<color=#ff0000>"..passCount .. "</color>/" .. allCount
    else
        txt = passCount .. "/" .. allCount
    end
    self.mImgProcess.fillAmount = math.floor(passCount / allCount * 100) / 100
    self.mTxtProNum.text = txt

    local txtColor = "242728ff"  
    if not self:getAreaVo():getIsOpen(GameManager:getServerTime()) then 
        self.mNormal:SetActive(false)
        self.mLock:SetActive(true)
        self.mComplete:SetActive(false)
        self.mTxtDup:SetActive(false)
        self.mTxtOpenDate.gameObject:SetActive(true)
        self.mTxtOpenDate.text = string.substitute("周{0}/{1}/{2}开放", DayTypeStr[self:getAreaVo().openDate[1]], DayTypeStr[self:getAreaVo().openDate[2]], DayTypeStr[self:getAreaVo().openDate[3]])
        txtColor = "e8d2d2ff"
    else
        
        -- Complete
        self.mTxtDup:SetActive(true)
        self.mTxtOpenDate.gameObject:SetActive(false)
        local info = dup.DupClimbTowerManager:getDeepDetail(self:getAreaVo().id)
        if info.curDup == 0 then 
            self.mNormal:SetActive(false)
            self.mComplete:SetActive(true)
            self.mLock:SetActive(false)
            txtColor = "ffffffff"
            -- self.mTxt_01.text = math.floor(progress * 100) 
        else    --Normal
            self.mNormal:SetActive(true)
            self.mLock:SetActive(false)
            self.mComplete:SetActive(false)
        end

        -- local canRec = dup.DupClimbTowerManager:canRecDeepAward(self:getAreaVo().id)
        -- if(canRec) then 
        --     RedPointManager:add(self:getTrans(), nil, -60, -41)
        -- else
        --     RedPointManager:remove(self:getTrans())
        -- end
    end
    self.mItemName.text = self:getAreaVo():getName()
    self.mItemName.color = gs.ColorUtil.GetColor(txtColor)
    -- self.mTxtPersent:SetActive(false)
end

function showOpenTxt(self)

end

function poolRecover(self)
    RedPointManager:remove(self:getTrans())
    -- gs.TransQuick:UIPos(self:getTrans(), -60, -41)
    super.poolRecover(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
