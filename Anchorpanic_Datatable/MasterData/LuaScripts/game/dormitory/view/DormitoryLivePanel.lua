--[[ 
-----------------------------------------------------
@filename       : DormitoryLivePanel
@Description    : 宿舍站员信息界面
@date           : 2023-02-15 16:09:43
@Author         : ZDH
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.view.DormitoryLivePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dormitory/DormitoryLivePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- isAddMask = 0
isBlur = 0

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mBtnClear = self:getChildGO("mBtnClear")
    self.mTextLiveNum = self:getChildGO("mTextLiveNum"):GetComponent(ty.Text)

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(dormitory.DormitoryHeroInfoItem)

    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mAni = self.UIObject:GetComponent(ty.Animator)
end

--激活
function active(self,roomId)
    super.active(self)

    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.updateView, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_HERELIST_UPDATE, self.updateView, self)

    self.m_RoomId = roomId

    local roomData = buildBase.BuildBaseManager:getBuildBaseData(self.m_RoomId)
    self.m_openLevel = roomData.lv

    local roomConfigData = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.m_RoomId)
    local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(roomConfigData.buildType)
    self.m_roomConfigData = levelsData:getLevelDataVo(self.m_openLevel)

    self:updateView()
end

-- 更新页面
function updateView(self)
    local settleLiveCount = self.m_roomConfigData:getNum()
    local buildBaseMsgVo = buildBase.BuildBaseManager:getBuildBaseData(self.m_RoomId)
    local heroList = buildBaseMsgVo.heroList

    local heroDataList = {}
    for i = 1, settleLiveCount do
        local data = {heroTid = heroList[i]}
        table.insert(heroDataList, data)
    end

    self.mLyScroller.DataProvider = heroDataList

    self.mTextLiveNum.text = string.format("进驻人员：%s/%s",#heroList,settleLiveCount)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE,self.updateView, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_HERELIST_UPDATE,self.updateView, self)
    self.mLyScroller:CleanAllItem()
    self.notClickClose = nil
end

function onClickClose(self)
    if self.notClickClose then return end

    GameDispatcher:dispatchEvent(EventName.CLOSE_DORMITORYLIVE_PANEL)
    self.notClickClose = true
    self.mAni:SetTrigger("exit")
    local time = AnimatorUtil.getAnimatorClipTime(self.mAni, "DormitoryLivePanel_Exit")
    self:setTimeout(time,function ()
        super.onClickClose(self)
    end)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClear, self.onClearAllLive)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

--清空所有站员
function onClearAllLive(self)
    GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_HEROLIST, {build_id = self.m_RoomId,hero_list = {}})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49716):	"<size=24>选</size>择战员"
]]
