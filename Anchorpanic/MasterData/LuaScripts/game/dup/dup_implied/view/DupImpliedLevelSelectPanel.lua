--[[ 
-----------------------------------------------------
@filename       : DupImpliedLevelSelectPanel
@Description    : 默示之境副本页面
@date           : 2021-07-05 17:53:11
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.view.DupImpliedLevelSelectPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedLevelSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

--析构  
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mLevelTxt = self:getChildGO("mLevelTxt"):GetComponent(ty.Text)
    self.mRecommendTxt = self:getChildGO("mRecommendTxt"):GetComponent(ty.Text)
    self.mDesTxt = self:getChildGO("mDesTxt"):GetComponent(ty.Text)
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.UnlockTxt = self:getChildGO("UnlockTxt"):GetComponent(ty.Text)
    self.mItemScrollerContent = self:getChildTrans("mItemScrollerContent")
    self.mItemScroller = self:getChildGO("mItemScroller"):GetComponent(ty.ScrollRect)


    self.mLevelScroller = self:getChildGO("mLevelScroller"):GetComponent(ty.LyScroller)
    self.mLevelScroller:SetItemRender(dup.DupImpliedLevelSelectItem)


    self.mAnimator = self.UIObject:GetComponent(ty.Animator)

    self:setGuideTrans("funcTips_codeImplied_change", self:getChildTrans("mBtnGet"))
end

--激活
function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.DUPIMPLIED_SELECTLEVEL, self.onLevelSelect, self)

    local diffList = dup.DupImpliedManager:getImpliedLevelList()
    self.mLevelScroller.DataProvider = diffList

    local curDiffId = dup.DupImpliedManager:getImpliedDiffId()
    if curDiffId == 0 then
        local roleVo = role.RoleManager:getRoleVo()
        local playerLevel = roleVo:getPlayerLvl()

        for k, diffId in pairs(diffList) do
            local diffVo = dup.DupImpliedManager:getStageDifficultyVo(diffId)
            if playerLevel >= diffVo.level then
                if diffId > curDiffId then
                    curDiffId = diffId
                end
            end
        end
    end
    self.isEnter = true
    GameDispatcher:dispatchEvent(EventName.DUPIMPLIED_SELECTLEVEL, curDiffId)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.DUPIMPLIED_SELECTLEVEL, self.onLevelSelect, self)
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtGet.text = "确认难度"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnGet"), self.onConfirm)
end

function onConfirm(self)
    if self.isLock then
        gs.Message.Show("等级不足无法选择")
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_DUP_IMPLIED_LEVELSELECT, self.mCurSelectDiffId)
    super.close(self)
end

--难度选中
function onLevelSelect(self, diffId)
    if self.mCurSelectDiffId == diffId then return end
    self.mCurSelectDiffId = diffId
    local diffVo = dup.DupImpliedManager:getStageDifficultyVo(diffId)
    if diffVo then
        local show = function ()
            self.mItemScroller.horizontalNormalizedPosition = 0

            local roleVo = role.RoleManager:getRoleVo()
            local playerLevel = roleVo:getPlayerLvl()
            self.isLock = playerLevel < diffVo.level

            self.mRecommendTxt.text = diffVo.level
            self.mLevelTxt.text = string.format("%s", diffVo.diffId)
            self.mDesTxt.text = diffVo.desc

            if self.isLock then
                self.UnlockTxt.text = _TT(121, diffVo.level)
            else
                self.UnlockTxt.text = ""
            end

            if not self.mItemList then
                self.mItemList = {}
            end
            self:recoverAwardItem()
            local list = diffVo.showDrop
            for i, vo in ipairs(list) do
                local propsGrid = PropsGrid:create(self.mItemScrollerContent, { vo.tid, vo.num }, 1, false)
                table.insert(self.mItemList, propsGrid)
            end
        end

        if not self.isEnter then 
            self:setTimeout(0.2,show)
        else
            show()
        end
    end

    if self.isEnter == true then
        self.isEnter = false
    else
        if self.mAnimator and not gs.GoUtil.IsCompNull(self.mAnimator) then
            self.mAnimator:SetTrigger("show")
        end

    end
end

-- 回收项
function recoverAwardItem(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
    end
    self.mItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
