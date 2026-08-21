module("seabed.SeabedStoryItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("seabed/item/SeabedStoryItem.prefab")
-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mIsLock = self:getChildGO("mIsLock")
end

function active(self)
    super.active(self)

end

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
    self:addOnClick(self:getChildGO("mImgIcon"), self.onClickItemHandler)
end

function onClickItemHandler(self)

    if self.isUnLock == true then

        --gs.Message.Show("暂时没有对应的剧情内容 等剧情内容正式后@心天还原播放剧情的功能")
        storyTalk.StoryTalkManager:setCurStoryID(self.mData.storyId)
        GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
    else
        gs.Message.Show(_TT(27536))
    end

end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData

    if self.aniSn then
        self:clearTimeout(self.aniSn)
        self.aniSn = nil
    end
    self.UIObject:SetActive(false)
    self.aniSn = self:setTimeout(self.mData.index * 0.03, function()
        self.UIObject:SetActive(true)
        self.UIObject:GetComponent(ty.UIDoTween):BeginTween()
        -- self.mAnimator:SetTrigger("enter")
    end)

    self:updateView()
end

function updateView(self)
    self.mTxtName.text = _TT(self.mData.title)
    self.mTxtDes.text = _TT(self.mData.des)

    self.mImgIcon:SetImg(UrlManager:getIconPath("seabed/" .. self.mData.icon), false)

    self.isUnLock = seabed.SeabedManager:getSeabedStoryListIsUnLock(self.mData.storyId)
    self.mIsLock:SetActive(not self.isUnLock)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27536):	"剧情未解锁"
]]
