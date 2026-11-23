




ComData = {

    skipJump = nil,

    newyearData = nil,

    CollectorGallery = {
        CollectorGalleryData = nil,
        CollectorGalleryType2Data = nil,
        CollectorGalleryAchieveNum = nil,
    },
    CollectorPracticeShop = nil,
    branchData = {
        oldPlayerData = {},
        pageindex = nil,
        pageIds = nil,
        bookindex = nil,
        beforbattleId = nil,
        beforbattlestate = false,
        novelIndex = nil,
        novelParam = nil,
        novelEvent = nil,
        BattleGoto = nil,
        NorvelGoto = nil,
        NetredDataTab = nil,
        BooKLockCondition = nil,
    },

    MainPageChickFirstShow = false,

    MainPageChickShowTime = 0,
    ConnectFourAiClose = false,
    NonsenseSaveTime = function()
        return ComData.MainPageChickShowTime
    end;
    CloseConnectFourAi = function()
        ComData.ConnectFourAiClose = true
    end
}

ComData.SetPageIndex = function(index, chapterID)
    ComData.branchData.pageindex = index
    ComData.branchData.pageIds = chapterID
end

ComData.SetBookIndex = function(bookIndex)
    ComData.branchData.bookindex = bookIndex
end

ComData.SetJumpType = function(type, storyID, branchID)
    if tonumber(type) == 1 then
        local novelIndex = 0
        for i, v in ipairs(ConfigMgr.Config.branchEventList) do
            if v.storyID == storyID then
                novelIndex = novelIndex + 1
                if v.ID == branchID then
                    break
                end
            end
        end
        ComData.branchData.novelIndex = novelIndex
        ComData.branchData.BattleGoto = nil
        ComData.branchData.NorvelGoto = true
    elseif tonumber(type) == 2 then
        ComData.branchData.BattleGoto = true
        ComData.branchData.NorvelGoto = nil
    end
end

return ComData