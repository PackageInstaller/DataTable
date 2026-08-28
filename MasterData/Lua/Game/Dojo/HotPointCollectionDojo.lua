--region import

--endregion

--region defines

--endregion



---@class HotPointCollectionDojo
local HotPointCollectionDojo = Class('HotPointCollectionDojo')


function HotPointCollectionDojo:__init()
    self.activityList = nil
    self.moduleList = nil
    self.cardInfo = nil
    self.hotSpotCollectionPvImage = nil
    self.pvLink = nil
    self.startTime = nil
    self.endTime = nil
    self.subtitle = nil
    self.title = nil
    self.pvTitle = nil
    self.entrance = nil
end


function HotPointCollectionDojo:__delete()

end

--activity list 活动信息
    ---- type int 类型1活动 2功能
    ---- tab int 页签
    ---- jumpActivityUuid int 关联活动唯一id
    ---- functionId int 系统功能表id
    ---- startTime int 开始时大于0倒计时 小于0 已开启的时间
    ---- endTime int 倒计时大于0倒计时 小于0 已结束
    ---- hotspotCollectionImage str 热点活动图
--cardInfo list 卡牌信息
    ---- cardAssociationIds list 卡牌关联活动页签id
    ---- sceneId str 背景
    ---- rewardImg str 角色立绘
    ---- cardId str 卡牌ID
    ---- catId str 猫spine 名称
    ---- catName str  猫名称
    ---- line str  台词
-- hotspotCollectionPvImage str pv图片
-- pvLink str pv链接
-- startTime int 情绪恢复 0关闭 1开启开始时大于0倒计时 小于0 已开启的时间
-- endTime int 倒计时大于0倒计时 小于0 已结束
-- subtitle str 版本副标题
-- title str 版本名称
-- pvTitle str Pv标题文字
-- pvVideoPath str Pv视频路径

---Fill
---填充数据
---@param jsonData table
function HotPointCollectionDojo:Fill(jsonData)
    local activityData            = checkTable(jsonData.activity)
    local activityList = {}
    local moduleList   = {}
    local tabId2Data   = {}
    local curTime = GameUtils.GetServerTime()
    for index, value in ipairs(activityData) do
        local vType = checkNumber(value.type)
        local vTab  = checkNumber(value.tab)
        value.type = vType
        GameUtils.ConventSingleSecondToTimeStamp(value, curTime)
        if vType == 1 then
            table.insert(activityList, value)
        elseif vType == 2 then
            table.insert(moduleList, value)
        end
        tabId2Data[vTab] = value
    end

    self.activityList             = activityList
    self.moduleList               = moduleList
    self.tabId2Data               = tabId2Data

    local cardInfo, skinInfo                = self:FixCardInfo(checkTable(jsonData.cardInfo))
    self.cardInfo = cardInfo
    self.skinInfo = skinInfo
    
    self.hotSpotCollectionPvImage = jsonData.hotspotCollectionPvImage
    self.pvLink                   = jsonData.pvLink
    self.startTime                = jsonData.startTime
    self.endTime                  = jsonData.endTime
    self.subtitle                 = jsonData.subtitle
    self.title                    = jsonData.title
    self.pvTitle                  = jsonData.pvTitle
    self.pvVideoPath              = checkString(jsonData.pvVideoPath)
    if not string.isEmpty(jsonData.entrance) then
        self.entrance                 = parse_pathNameByData(jsonData.entrance, ".png")
    end

    GameUtils.ConventSingleSecondToTimeStamp(self)

    return self
end

function HotPointCollectionDojo:FixCardInfo(cardInfo)
    local skinInfo = {}
    local info = {}
    for index, value in pairs(cardInfo) do
        local id = checkNumber(value.id)
        local idType = GoodsUtils.GetIdType(id)

        if idType == Constants.IDType.CharacterCard then
            value.cardId = id
            local cardVo = CardConfMgr:GetInstance():GetCardByRefId(id) or {}
            value.skinId = cardVo.defaultSkin

            table.insert(info, value)

        elseif idType == Constants.IDType.CardSkin then
            value.skinId = id
            local skinVo = CardConfMgr:GetInstance():GetCardSkinBySkinId(id) or {}
            value.cardId = skinVo.roleId

            table.insert(skinInfo, value)
        end

        value.line   = checkString(value.line)
    end

    return info, skinInfo
end

return HotPointCollectionDojo
