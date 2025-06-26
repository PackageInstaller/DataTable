module("gm.GmTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("gm/GmTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mInput = nil
    self.mTextGmTip = nil
    self.mBtnSend = nil
    self.mGroupLeftTrans = nil
    self.mGroupRightTrans = nil

    self.mLeftItemGoList = {}
    self.mRightItemGoList = {}
end

function configUI(self)
    super.configUI(self)
    self.mInput = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.mTextGmTip = self:getChildGO("GmTipText"):GetComponent(ty.Text)
    self.mBtnSend = self:getChildGO("SendButton")
    self.mBtnDel = self:getChildGO("DelButton")
    self.mSaveButton = self:getChildGO("mSaveButton")
    self.mGroupLeftTrans = self:getChildTrans("GroupLeft")
    self.mGroupRightTrans = self:getChildTrans("GroupRight")

    self.mBtngfs = self:getChildGO("mBtngfs")
    self.mBtnPlayerPrefs = self:getChildGO("mBtnPlayerPrefs")
    self.mBtnNb = self:getChildGO("mBtnNb")
    self.mBtnGuide = self:getChildGO("mBtnGuide")

    self.mToogleRuntimeInspector = self:getChildGO("mToogleRuntimeInspector"):GetComponent(ty.Toggle)
    self.mToogleRuntimeInspector.isOn = gm.GmManager.mRunTimeInspectorToogle

    self.mBtnTank = self:getChildGO("mBtnTank")
    self.mBtnVsSelf = self:getChildGO("mBtnVsSelf")

    self.mBtnMaxQuality = self:getChildGO("mBtnMaxQuality")

    self.mBtnFieldExploration = self:getChildGO("mBtnFieldExploration")

    self.mBtnLastFashion = self:getChildGO("mBtnLastFashion")
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_GM_PANEL, self.__updateView, self)
    self:__updateView()

    local cmd = StorageUtil:getString0('gmCmdLog')
    self.mInput.text = cmd or ''
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GM_PANEL, self.__updateView, self)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSend, self.onClickSendHandler)
    self:addUIEvent(self.mBtnDel, self.onClickDelHandler)
    self:addUIEvent(self.mBtngfs, self.onGFS)
    self:addUIEvent(self.mBtnNb, self.onDzt)
    self:addUIEvent(self.mBtnGuide, self.onResGuide)
    self:addUIEvent(self.mBtnFieldExploration, self.onFieldExploration)

    self:addUIEvent(self.mBtnTank, self.onTank)
    self:addUIEvent(self.mBtnVsSelf, self.onVsSelf)
    self:addUIEvent(self.mBtnPlayerPrefs, self.onClearPlayerPrefs)
    self:addUIEvent(self.mSaveButton, self.onSave)

    self:addUIEvent(self.mBtnLastFashion , self.onLastFashion)
    -- self:addUIEvent(self.mToogleRuntimeInspector, self.onLoadInspectorHandler)

    local function onLoadInspectorHandler(value)
        if(value and gm.GmManager.mRunTimeInspector == nil) then
            gs.ResMgr:LoadGOAysn("arts/prefabs/ui/gm/RuntimeInspectorView.prefab", function(go)
                gm.GmManager.mRunTimeInspector = go
                go.transform:SetParent(GameView.gm, false)
                gs.Message.Show("启动完成")
            end)
            gm.GmManager.mRunTimeInspectorToogle = value
            return
        end
        if(gm.GmManager.mRunTimeInspector ~= nil) then
            gm.GmManager.mRunTimeInspector:SetActive(value)
        end
        gm.GmManager.mRunTimeInspectorToogle = value
    end

    self.mToogleRuntimeInspector.onValueChanged:AddListener(onLoadInspectorHandler)
    self:addUIEvent(self.mBtnMaxQuality, self.onMaxQuality)
end

function onFieldExploration(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_DANKE_STAGEPANEL)

    -- fieldExploration.FieldExplorationManager:setActivityId(220)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Gold, param = {activity_id = 220}})

    -- fieldExploration.FieldExplorationManager:setDupId(20001)
    -- GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.FIELD_EXPLORATION)

    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.BIG_HOSTEL)
end

function onLastFashion(self)
    local heroVoList = hero.HeroManager:getHeroList()

    for i = 1, #heroVoList, 1 do
        local dic = fashion.FashionManager:getHeroFashionConfigDic(fashion.Type.CLOTHES,heroVoList[i].tid)
        local maxId =0
        for k, v in pairs(dic) do
            local isLock = fashion.FashionManager:getHeroFashionVo(fashion.Type.CLOTHES,heroVoList[i].id, v.fashionId)
            if v.fashionId > maxId and isLock then
                maxId = v.fashionId
            end
        end

        --if maxId > 0 then
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_WEAR_FASHION, {
                fashionType = fashion.Type.CLOTHES,
                heroId = heroVoList[i].id,
                fashionId = maxId
            })
        --end
    end
    gs.Message.Show("穿戴了拥有战员拥有的最大ID时装，还不谢谢我ヾ(･ω･`｡)")
end

function onSave(self)
    gs.Message.Show("帮你保存了，还不谢谢我ヾ(･ω･`｡)")
    StorageUtil:saveString0('gmCmdLog', self.mInput.text)
end

function onClearPlayerPrefs(self)
    CS.UnityEngine.PlayerPrefs.DeleteAll()
    gs.Message.Show("清理完成")
end

function onMaxQuality(self)
    -- -- - 默认的 targetFrameRate 是一个特殊值 -1，表示游戏应以平台的默认帧率渲染。此默认速率取决于平台：
    -- -- - 在独立平台上，默认帧率是可实现的最大帧率。
    -- -- - 在移动平台上，由于需要节省电池电量，默认帧率小于可实现的最大帧率。移动平台上的默认帧率通常为每秒 30 帧。
    -- gs.Application.targetFrameRate = 999
    -- gs.QualitySettingsUtil.SetVSyncCount(0)
    -- systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.quality, 4)
    -- gs.Message.Show("临时解除帧数限制 关闭垂直同步 开高了渲染精度")
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality, 5)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.frameCount, 2)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.quality, 5)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.shadow, 4)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.effect, 3)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.vSyns, 2)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.anti_Aliasing, 2)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.bloom, 2)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.dispersion, 2)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.radial_Blur, 2)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.special_effect_distortion, 2)
    systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.post_processing, 2)

    for k, v in pairs(systemSetting.QualitySettingDrop) do
        systemSetting.SystemSettingManager:applySetting(v.key)
    end

    gs.Message.Show("开启最高画质参数设置，画面质量=自定义，帧率 = 60，渲染精度 = 原始,阴影质量 = 高,特效质量 = 高,垂直同步、抗锯齿、Bloom、色散、径向模糊、特效扭曲后处理,全开")
end

function onGFS(self)
    local strArr = {"set_lvl 60", "gm_open_all", "add_all_hero", "set_titanium 9999999",
    "set_gold_coin 9999999", "set_stamina 999", "maxpower_hero", "set_mainstory 2 1", "set_hero 1 60", "set_hero 2 60", "set_hero 3 60"}
    for i = 1, #strArr do
        GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, {command = strArr[i]})
    end

    gs.Message.Show("恭迎龙王Orz~ 顺便帮你屏蔽了音效和开高画质")
end
function onDzt(self)
    local strArr = {"set_hero 1 60", "set_hero 2 60", "set_hero 3 60", "maxpower_hero"}
    for i = 1, #strArr do
        GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, {command = strArr[i]})
    end
    gs.Message.Show("你变得无敌强了")
end

-- 菜鸡互啄
function onTank(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, {command = "tankpower_hero"})
    gs.Message.Show("双方战员又肉又没伤害了(゜▽＾*))")
end

-- vs自己的竞技场防守阵容
function onVsSelf(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, {command = "battle_test_area_def"})
    gs.Message.Show("vs自己的竞技场防守阵容[○･｀Д´･ ○]")
end

function onResGuide(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, {command = "clear_guide"})
    StorageUtil:saveString0('login_guide', 0)
    gs.Message.Show("重置引导完成")
end

function __updateView(self)
    self:__recoveryLeftItemList()
    self:__recoveryRightItemList()

    local cmdDic = gm.GmManager.cmdDic
    local cmdModuleList = gm.GmManager.cmdModuleList
    if (not cmdDic) then
        GameDispatcher:dispatchEvent(EventName.REQ_GM_LIST)
        return
    end
    -- for module, cmdList in pairs(cmdDic) do
    for _, module in pairs(cmdModuleList) do
        local itemGo = gs.GOPoolMgr:Get(self:__getItemPrefabName())
        local childGos, childTrans = GoUtil.GetChildHash(itemGo)
        childGos["Text"]:GetComponent(ty.Text).text = module
        itemGo.transform:SetParent(self.mGroupLeftTrans, false)
        local rect = itemGo:GetComponent(ty.RectTransform)
        gs.TransQuick:Scale(rect, 1, 1, 1)

        local cmdList = cmdDic[module]
        local function clickItem()
            self:__onClickLeftItemHandler(cmdList)
        end
        self:addOnClick(itemGo, clickItem)
        table.insert(self.mLeftItemGoList, itemGo)
    end
end

function __recoveryLeftItemList(self)
    local len = #self.mLeftItemGoList
    for i = 1, len do
        local itemGo = self.mLeftItemGoList[i]
        self:removeOnClick(itemGo)
        gs.GOPoolMgr:Recover(itemGo, self:__getItemPrefabName())
    end
    self.mLeftItemGoList = {}
end

function __recoveryRightItemList(self)
    local len = #self.mRightItemGoList
    for i = 1, len do
        local itemGo = self.mRightItemGoList[i]
        self:removeOnClick(itemGo)
        gs.GOPoolMgr:Recover(itemGo, self:__getItemPrefabName())
    end
    self.mRightItemGoList = {}
end

function __getItemPrefabName(self)
    return UrlManager:getUIPrefabPath("gm/GmItem.prefab")
end

function __onClickLeftItemHandler(self, cmdList)
    self:__recoveryRightItemList()

    local len = #cmdList
    for i = 1, len do
        local cmdVo = cmdList[i]

        local itemGo = gs.GOPoolMgr:Get(self:__getItemPrefabName())
        local childGos, childTrans = GoUtil.GetChildHash(itemGo)
        childGos["Text"]:GetComponent(ty.Text).text = cmdVo.desc
        itemGo.transform:SetParent(self.mGroupRightTrans, false)
        local rect = itemGo:GetComponent(ty.RectTransform)
        gs.TransQuick:Scale(rect, 1, 1, 1)

        local function clickItem()
            self:__onClickRightItemHandler(cmdVo)
        end
        self:addOnClick(itemGo, clickItem)
        table.insert(self.mRightItemGoList, itemGo)
    end
end

function __onClickRightItemHandler(self, cmdVo)
    self.mTextGmTip.text = "例子：" .. cmdVo.cmd
    if (self.mInput.text == "") then
        self.mInput.text = cmdVo.example
    else
        self.mInput.text = self.mInput.text .. "\n" .. cmdVo.example
    end
end

-- 删除
function onClickDelHandler(self)
    StorageUtil:saveString0('gmCmdLog', "")
    self.mInput.text = ""
end

-- 发送命令
function onClickSendHandler(self)
    local content = self.mInput.text
    if (content ~= "") then
        if (content == "充值") then
            -- 方式1
            local list = recharge.RechargeManager:getAllRechargeList(recharge.RechargeType.MONEY_ITIANIUM)
            if (list and #list > 0) then
                GameDispatcher:dispatchEvent(EventName.REQ_RECHARGE, {type = list[1].type, itemId = list[1].itemId, itemTitle = "GM购买", itemName = "源质水晶", itemDes = "GM调起第一个货币购买订单"})
            else
                print("充值列表为空")
            end
            -- 方式2
            -- -- xxx自定义的限制条件
            -- local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.MONEY_ITIANIUM, nil, xxx)
            -- local itemId = rechargeVo and rechargeVo.id or ""
            -- GameDispatcher:dispatchEvent(EventName.REQ_RECHARGE, {type = recharge.RechargeType.MONEY_ITIANIUM, subType = nil, itemId = itemId, itemTitle = "GM购买", itemName = "源质水晶", itemDes = "GM调起第一个货币购买订单" })
        elseif (content == "restart") then
            gs.SdkManager:RestartApplication()
        elseif (content == "close") then
            gs.SdkManager:CloseApplication()
        elseif (content == "reset") then
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, {})
        elseif (content == "clear download") then
            local moduleType = 10000
            download.ResDownLoadManager:setModuleAssetsSign(10000, false)
            local result = download.ResDownLoadManager:delDownloadedModuleAssets(moduleType)
            if(result == true)then
                gs.Message.Show("删除下载成功")
            end
        else
            local strArr = string.split(content, "\n")
            for i = 1, #strArr do
                GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, {command = strArr[i]})
            end
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
