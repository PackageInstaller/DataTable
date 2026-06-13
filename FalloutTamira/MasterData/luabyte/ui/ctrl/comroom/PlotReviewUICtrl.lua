local M = BaseClass("PlotReviewUICtrl", BaseUICtrl)
local TypeEnum = EnumConst.StoryBookType
local tInsert = table.insert
-- 剧情图鉴

function M:Init()
    self.m_subType = nil
    local itemCtrl = require("UI.Ctrl.ComRoom.PlotReviewChapterItemCtrl")
    local itemView = require("UI.View.ComRoom.PlotReviewChapterItemView")
    self._view.node_list:Init(itemCtrl, itemView)
    self.m_onCallback = Bind(self, self.OnClickItem)
    self._view.btn_back:onClick(Bind(self, self.Close))
    self._view.node_list:SetCreateItemCallback(Bind(self, self.OnCreateItem))
    self.m_banners = { self._view.banner1, self._view.banner2, self._view.banner3, self._view.banner4 }
    self.m_images = { self._view.img_pic1, self._view.img_pic2, self._view.img_pic3, self._view.img_pic4 }
    self.m_names = { self._view.txt_name1, self._view.txt_name2, self._view.txt_name3, self._view.txt_name4 }

    self._view.img_pic1:onClick(Bind(self, self.OnClickBanner, TypeEnum.Main))
    self._view.img_pic2:onClick(Bind(self, self.OnClickBanner, TypeEnum.Activity))
    self._view.img_pic3:onClick(Bind(self, self.OnClickBanner, TypeEnum.Personal))
    self._view.img_pic4:onClick(Bind(self, self.OnClickBanner, TypeEnum.Dorm))
end

function M:OnEnter()
    self.m_dataDic = {}
    local curTime = TimeUtil.GetNowTimeStamp()
    for _type, tbl in pairs(PlotAtlasDataMgr:GetInstance():GetBookStoryTypes()) do
        local subTypeList, mainName, mainPath = {}, nil, nil
        for _, bookStoryChapter in ipairs(tbl) do
            if (bookStoryChapter.time == 0) or (bookStoryChapter.time < curTime) then -- 是否显示
                if not mainName then mainName = bookStoryChapter.typeName end
                if not mainPath then mainPath = bookStoryChapter.typePicture end
                local name, picPath = bookStoryChapter.subTypeName, bookStoryChapter.subTypePicture
                local group, unlockNum, totalNum, subType = {}, 0, 0, bookStoryChapter.subType
                local bookStorys = PlotAtlasDataMgr:GetInstance():GetBookStorysBySubType(subType)
                for _, cfg in ipairs(bookStorys or {}) do
                    if (cfg.time == 0) or (cfg.time < curTime) then
                        local lockId = GameHelper.GetFirstLockReason(cfg.openCondition)
                        if lockId <= 0 then unlockNum = unlockNum + 1 end
                        totalNum = totalNum + 1
                        tInsert(group, { Id = cfg.id, Type = _type, LockId = lockId, Config = cfg })
                    end
                end
                if #group > 0 then
                    tInsert(subTypeList, {
                        EntryId = bookStoryChapter.id,
                        Type = _type,
                        SubType = (_type == TypeEnum.Main or _type == TypeEnum.Activity) and subType or nil,
                        Name = name,
                        PicPath = picPath,
                        Groups = group,
                        UnlockNum = unlockNum,
                        TotalNum = totalNum
                    })
                end
            end
        end
        if #subTypeList > 0 then
            self.m_dataDic[_type] = subTypeList
            self.m_banners[_type]:SetActive(true)
            self.m_images[_type]:SetPic(mainPath)
            self.m_names[_type]:SetText(mainName)
        else
            self.m_banners[_type]:SetActive(false)
        end
    end

    -- 当大类类型仅显示1的时候则不显示大类页面直接进入到1大类的子类型页签页面即可
    if table.count(self.m_dataDic) == 1 then
        self._view.node_list:SetActive(true)
        self._view.mainPanel:SetActive(false)
        for _, v in pairs(self.m_dataDic) do
            self._view.node_list:SetDataList(v)
        end
    else
        self._view.node_list:SetActive(false)
        self._view.mainPanel:SetActive(true)
    end
end

function M:OnVisible()
    if self.m_subType and (self.m_subType == TypeEnum.Personal) then
        local inst = PlotAtlasDataMgr:GetInstance()
        for _, tbl in ipairs(self._view.node_list:GetDataList()) do
            local unlockNum = 0
            for _, v in ipairs(tbl.Groups) do
                if inst:IsUnlockStoryBook(v.Id) then unlockNum = unlockNum + 1 end
            end
            tbl.UnlockNum = unlockNum
        end
        self._view.node_list:UpdateList()
    end
end

function M:OnBack()
    if self.m_subType then
        self._view.node_list:SetActive(false)
        self._view.mainPanel:SetActive(true)
        self.m_subType = nil
        return false
    end

    return true
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnDispose()
    self.m_names = nil
    self.m_images = nil
    self.m_banners = nil
    self.m_dataDic = nil
    self.m_onCallback = nil
    M.super.OnDispose(self)
end

function M:OnClickBanner(_type, go)
    local list = self.m_dataDic[_type]
    if not list then return end
    self.m_subType = _type
    self._view.node_list:SetActive(true)
    self._view.mainPanel:SetActive(false)
    if (_type == TypeEnum.Personal) or (_type == TypeEnum.Dorm) then
        local ids, inst = {}, PlotAtlasDataMgr:GetInstance()
        for _, v in ipairs(list) do table.insert(ids, v.EntryId) end
        inst:SendEnterBookStory({ Ids = ids }, function()
            if _type == TypeEnum.Personal then
                for _, tbl in ipairs(list) do
                    local unlockNum = 0
                    for _, v in ipairs(tbl.Groups) do
                        if inst:IsUnlockStoryBook(v.Id) then
                            unlockNum = unlockNum + 1
                        end
                    end
                    tbl.UnlockNum = unlockNum
                end
            end
            self._view.node_list:SetDataList(list)
        end)
    else
        self._view.node_list:SetDataList(list)
    end
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallback(self.m_onCallback)
end

function M:OnClickItem(data, idx)
    if not data then return end

    if data.Type == TypeEnum.Personal then
        UIContextMgr:GetInstance():Show("PlotStoryUnlockUI", data.Groups)
    else
        UIContextMgr:GetInstance():Show("PlotReviewList", data, idx)
    end
end

return M
