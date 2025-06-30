module("PlayerHeadGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/PlayerHeadGrid.prefab")

function __initData(self)
    super.__initData(self)

    -- 一些常用的脚本
    self.mTxtName = nil
    self.mTxtLvl = nil
    self.mImgHead = nil
    self.mGroupFrame = nil


    --------------------------------------------- 数据源 self.m_data 为玩家头像id ---------------------------------------------
    -- 玩家名称
    self.mGridName = nil
    -- 玩家等级
    self.mPlayerLvl = nil
    -- 玩家头像框id
    self.mHeadFrameId = nil

    self.mGrayState = false

    if self.mIconMask then
        self.mIconMask:GetComponent(ty.Image).enabled = false
        self.mIconMask = nil
    end
    if self.mBgMask then
        self.mBgMask:GetComponent(ty.Image).enabled = false
        self.mBgMask = nil
    end

    if self.mHeadFrameGrid then
        self.mHeadFrameGrid:poolRecover()
        self.mHeadFrameGrid = nil
    end
    
    self.isRay = true
end

function __updateCustomView(self)
    self:updateName()
    self:updateLvl()
    self:updateHead()
    self:updateHeadFrame()
    self:updateGray()
    self:getChildGO("mImgSelect"):SetActive(false)
    self:getChildGO("mImgNew"):SetActive(false)

    self:updateClickRay()
    --self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage).raycastTarget = true
end

function setName(self, cusName)
    self.mGridName = cusName
    self:updateName()
end

function updateName(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtName == nil) then
            self.mTxtName = self.m_childTrans["mTxtName"]:GetComponent(ty.Text)
        end
        if (self.mGridName == nil) then
            self.mTxtName.text = ""
        else
            self.mTxtName.text = self.mGridName
        end
    end
end

function setLvl(self, cusLvl)
    self.mPlayerLvl = cusLvl
    self:updateLvl()
end

function updateLvl(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtLvl == nil) then
            self.mTxtLvl = self.m_childTrans["mTxtLvl"]:GetComponent(ty.Text)
        end
        if (self.mPlayerLvl == nil) then
            self.m_childGos["mGroupLvl"]:SetActive(false)
            self.mTxtLvl.text = ""
        else
            self.m_childGos["mGroupLvl"]:SetActive(true)
            self.mTxtLvl.text = self.mPlayerLvl
        end
    end
end

function setHeadFrame(self, headFrameId)
    self.mHeadFrameId = headFrameId
    self:updateHeadFrame()
end
--设置是否显示头像框（开启此设置头像和头像框只可显示一种）
function setIsShowFrame(self, isShowFrame)
    if self.m_isLoadFinish then
        self:getChildGO("mGroupFrame"):SetActive(isShowFrame)
        self:getChildGO("mGroupHead"):SetActive(not isShowFrame)
    end
end

--设置是否显示已解锁
function setIsLock(self, isLock)
    if self.m_isLoadFinish then
        self:getChildGO("mImgLockBg"):SetActive(isLock == false)
    end
end
--设置是否选中
function setIsSelect(self, isSelect)
    if self.m_isLoadFinish then
        self:getChildGO("mImgSelect"):SetActive(isSelect)
    end
end
--设置是否是新的
function setIsNew(self, isNew)
    if self.m_isLoadFinish then
        self:getChildGO("mImgNew"):SetActive(isNew)
    end
end
--设置头像
function setHead(self, modelId)
    if self.m_isLoadFinish then
        self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPlayerHeadUrl(modelId), true)
    end
end
--设置背景是否显示
function setActievBg(self, isActive)
    self:getChildGO("mImgBg"):SetActive(isActive)
end
--设置是否正在使用
function setIsUsing(self, isUsing, txtUsing)
    if self.m_isLoadFinish then
        self:getChildGO("mImgUsing"):SetActive(isUsing)
        self:getChildGO("mTxtUsing"):GetComponent(ty.Text).text = txtUsing
    end
end
function updateHeadFrame(self)
    if (self.m_isLoadFinish) then
        if (self.mGroupFrame == nil) then
            self.mGroupFrame = self.m_childTrans["mGroupFrame"]
            self.mIconMask = self.m_childGos["mIconMask"]
            self.mBgMask = self.m_childGos["mBgMask"]
        end

        local vo = decorate.DecorateManager:getPlayerHeadFrameConfigVo(self.mHeadFrameId)
        if (self.mHeadFrameId == nil or vo == nil) then
            self.mGroupFrame.gameObject:SetActive(false)
        else
            if not self.mHeadFrameGrid then
                self.mHeadFrameGrid = PlayerHeadFrameGrid:poolGet()
            end
            self.mHeadFrameGrid:setData(self.mHeadFrameId, self.mGroupFrame)
            self.mGroupFrame.gameObject:SetActive(true)

            if vo:getDynamics() == 2 then
                -- 原型头像框，对头像加遮罩
                self.mIconMask:GetComponent(ty.Image).enabled = true
                self.mBgMask:GetComponent(ty.Image).enabled = true
            else
                self.mIconMask:GetComponent(ty.Image).enabled = false
                self.mBgMask:GetComponent(ty.Image).enabled = false
            end
        end

        -- self.mGroupFrame.gameObject:SetActive(false) --暂时屏蔽
    end
end

function showHeadFrameAnim(self)
    if self.mHeadFrameGrid then
        self.mHeadFrameGrid:showEnterAnim()
    end
end

function updateHead(self)
    if (self.m_isLoadFinish) then
        if (self.mImgHead == nil) then
            self.mImgHead = self.m_childTrans["mImgHead"]:GetComponent(ty.AutoRefImage)
        end
        local iconSource = UrlManager:getHeroHeadUrlByImgName("hero_head_1101.png")
        local _data = self:getData()
        if type(_data) == "string" then
            iconSource = UrlManager:getPlayerHeadUrl(_data)
        else
            local headConfigVo = nil
            if (self:getData() == nil) then
                headConfigVo = decorate.DecorateManager:getDeaultPlayerHeadConfig()
            else
                headConfigVo = decorate.DecorateManager:getPlayerHeadConfigVo(_data)
            end
            if (headConfigVo) then
                -- 目前都一样
                if (headConfigVo:getUnlockType() == decorate.HeadUnlockType.DEFAULT_UNLICK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                elseif (headConfigVo:getUnlockType() == decorate.HeadUnlockType.PROPS_UNLOCK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                elseif (headConfigVo:getUnlockType() == decorate.HeadUnlockType.HERO_UNLOCK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                elseif (headConfigVo:getUnlockType() == decorate.HeadUnlockType.HERO_FASHION_UNLOCK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                end
            end
        end
        self.mImgHead:SetImg(iconSource, false)
        self:getChildGO("mGroupHead"):SetActive(true)
    end
end

function setClickRay(self,enable)
    self.isRay = enable
end

function updateClickRay(self)
    self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage).raycastTarget = self.isRay
end

function setGray(self, state)
    --这个置灰的方法存在问题 禁止使用
    --self.mGrayState = state
    --self:updateGray()
end

function updateGray(self)
    -- if (self.m_isLoadFinish) then
    --     if self.mGrayState then
    --         gs.MatUtil.UIToGray(self.m_uiGo, true)
    --     else
    --         gs.MatUtil.UIToEmptyMaterial(self.m_uiGo, true)
    --     end
    -- end
end

return _M