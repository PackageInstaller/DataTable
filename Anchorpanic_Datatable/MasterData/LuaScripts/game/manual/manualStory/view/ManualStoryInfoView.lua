--[[ 
-----------------------------------------------------
@filename       : ManualStoryInfoView
@Description    : 图鉴-故事
@date           : 2023-3-5 17:43:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualStoryInfoView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualStoryInfoView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("故事")--故事
end
--析构  
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mStoryItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mItem = self:getChildGO("mItem")
    self.mStoryInfoContent = self:getChildTrans("mStoryInfoContent")
    self.mTxtMainDes = self:getChildGO("mTxtMainDes"):GetComponent(ty.Text)
    self.mTxtMainName = self:getChildGO("mTxtMainName"):GetComponent(ty.Text)
    self.mTxtMainIndex = self:getChildGO("mTxtMainIndex"):GetComponent(ty.Text)
end
--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.mStoryIndex = args.type
    self.mdata = manual.ManualStoryManager:getManualStoryVoByChapterId(self.mStoryIndex)
    self:setBg(self.mdata:getImg(), true, "story/cg")
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    self:closeStoryItemList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end


function updateView(self)
    self.mTxtMainDes.text = self.mdata:getDes()
    self.mTxtMainIndex.text = self.mdata:getSort()
    self.mTxtMainName.text = self.mdata:getName()
    for _, storyVo in ipairs(self.mdata:getStoryList()) do
        local isLock = self.mdata.type == manual.ManualStoryType.ActivityStory and true or storyVo:getIsUnlock()
        local item = SimpleInsItem:create(self.mItem, self.mStoryInfoContent, "ManualStoryInfoViewstoryStage")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = isLock and storyVo:getName() or _TT(25204)
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(storyVo:getImgUrl(), false)
        item:getChildGO("mImgUnlockBg"):SetActive(isLock == false)
        item:addUIEvent(nil, function()
            if isLock == false then
                gs.Message.Show(_TT(25204))
                return
            end
            storyTalk.StoryTalkManager:setCurStoryID(storyVo.stageId)
            GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
        end)
        table.insert(self.mStoryItemList, item)
    end
end

function closeStoryItemList(self)
    if #self.mStoryItemList > 0 then
        for _, item in ipairs(self.mStoryItemList) do
            item:poolRecover()
            item = nil
        end
        self.mStoryItemList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]