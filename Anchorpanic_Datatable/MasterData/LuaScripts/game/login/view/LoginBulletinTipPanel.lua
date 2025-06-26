--[[   
     登录适龄提示界面
]] module('login.LoginBulletinTipPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('login/LoginBulletinTipPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle("        ")
end

-- 初始化数据
function initData(self)
end

-- 初始化
function configUI(self)
    self.mLeftBtn = self:getChildGO("mLeftBtn")
    self.mRightBtn = self:getChildGO("mRightBtn")

    self.mBtnClose = self:getChildGO("mBtnClose")    
    self.mTxtTitle = self:getChildGO('mTxtTitle'):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.TMP_Text)
    self.mTxtContentLink = self:getChildGO("mTxtContent"):GetComponent(ty.TextMeshProLink)
    self.mTxtContentLink:SetEventCall(function(position, localPosition, linkIdStr, linkTextStr) 
        notice.HrefUtil.commonNoticeDesLinkData(position, localPosition, linkIdStr, linkTextStr)
    end)

    self.mImgBanner = self:getChildGO("mImgBanner")
    -- self.mBannerEventTrigger = self.mImgBanner:GetComponent(ty.LongPressOrClickEventTrigger)

end

-- 激活
function active(self, args)
    super.active(self, args)
    self.mImgBanner:SetActive(false)
    -- self.mBannerEventTrigger.onLongPress:AddListener(function() end)

    self:updateView(args)

    self.mNeedClickTimer = {
        left = 5,
        right = 12
    }
    self.mCurClickTimer = {
        left = 0,
        right = 0
    }
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self.mBannerEventTrigger.onLongPress:RemoveAllListeners()
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mLeftBtn, self.onLeftClick)
    self:addUIEvent(self.mRightBtn, self.onRightClick)
end

function onLeftClick(self)
    self.mCurClickTimer.left = self.mCurClickTimer.left + 1
    self:updateClickTimer()
end

function onRightClick(self)
    self.mCurClickTimer.right = self.mCurClickTimer.right + 1
    self:updateClickTimer()
end

function updateClickTimer(self)
    self.mImgBanner:SetActive(self.mCurClickTimer.left == self.mNeedClickTimer.left and self.mCurClickTimer.right == self.mNeedClickTimer.right)
end

function updateView(self, args)
    self.mTxtTitle.text = args.title
    self.mTxtContent.text = gs.StringUtil.HtmlDecode(args.content)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
