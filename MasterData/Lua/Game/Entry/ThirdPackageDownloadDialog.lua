--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/MainDownLoadDialog.prefab > name: MainDownLoadDialog
---@class ThirdPackageDownloadDialog
---@field Env                           	ThirdPackageDownloadDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LowTxtNum                     	UnityEngine.RectTransform               	@ 0    
---@field LowImgGoods                   	UnityEngine.RectTransform               	@ 1    
---@field LowTxtName                    	UnityEngine.RectTransform               	@ 2    
---@field HighTxtName                   	UnityEngine.RectTransform               	@ 3    
---@field HighImgGoods                  	UnityEngine.RectTransform               	@ 4    
---@field HighTxtNum                    	UnityEngine.RectTransform               	@ 5    
---@field TxtNumber                     	UnityEngine.RectTransform               	@ 6    
---@field BtnMagnifier                  	UnityEngine.RectTransform               	@ 7    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 8    
---@field UpdateBottom2                 	UnityEngine.RectTransform               	@ 9    
---@field Slider                        	UnityEngine.RectTransform               	@ 10   
---@field TitleText                     	UnityEngine.RectTransform               	@ 11   
---@field TextNum                       	UnityEngine.RectTransform               	@ 12   
---@field ProText                       	UnityEngine.RectTransform               	@ 13   
---@field UpdateBottom1                 	UnityEngine.RectTransform               	@ 14   
---@field ButtonGroup                   	UnityEngine.RectTransform               	@ 15   
local ThirdPackageDownloadDialog = Class('ThirdPackageDownloadDialog')
---@type PreDownloadConstants
local PreDownloadConstants = import('Game.UI.PreDownload.PreDownloadConstants')
local ThirdDownloadManager = import('Game.Entry.ThirdDownloadManager'):GetInstance()
local SmallPackageDownloaded = "SmallPackageDownloaded"
local ThirdPackageDownloaded = "ThirdPackageDownloaded"
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
local Utils = CS.Engine.Tools.Utils
local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
local ParamDefine = {
    GOOD_ID = 1,
    UNLOCK_CONDITION_ID = 2,
    UNLOCK_CONDITION_NUM = 4,
    TOAST_ID = 5,
    MONTHLY_DELTA = 6,
    REWARD_GOOD_ID = 7,
}


function ThirdPackageDownloadDialog:__init()

end

function ThirdPackageDownloadDialog:OnShow()
    CfUtils.SetSliderPercent(self.Slider , 0)
    CfUtils.FillText(self.TextNum , '')
    CfUtils.FillText(self.ProText , '0%')
    CfUtils.FillText(self.TitleText ,localize("正在下载"))
end
--region private
---切换状态
---@param status PreDownloadConstants.DownloadStatus 下载状态
---@param params table 额外参数
function ThirdPackageDownloadDialog:SwitchStatus(status, params)
    if status == PreDownloadConstants.DownloadStatus.None then
        self:SwitchDefaultStatus()
    elseif status == PreDownloadConstants.DownloadStatus.Starting then
        self:SwitchStartStatus()
    elseif status == PreDownloadConstants.DownloadStatus.Progressing then
        self:SwitchProgressingStatus(params.downloadSize, params.totalSize, params.progress, params.speed)
    elseif status == PreDownloadConstants.DownloadStatus.ResourceMarge then
        self:SwitchMargeStatus()
    elseif status == PreDownloadConstants.DownloadStatus.ResourceCheck then
        self:SwitchCheckStatus()
    elseif status == PreDownloadConstants.DownloadStatus.ResourceNewCheck then
        self:SwitchCheckPrograssStatus(params.progress)
    elseif status == PreDownloadConstants.DownloadStatus.Error then
        self:SwitchErrorStatus(params.error)
    elseif status == PreDownloadConstants.DownloadStatus.DownloadDone then
        self:SwitchDownloadDoneStatus()
    elseif status == PreDownloadConstants.DownloadStatus.Decompressing then
        self:SwitchDecompressingStatus(params.progress)
    elseif status == PreDownloadConstants.DownloadStatus.FinishNext then
        self:SwitchResourceUpdateStartStatus()
    elseif status == PreDownloadConstants.DownloadStatus.ResourceUpdateStart then
        self:SwitchResourceUpdateStartStatus()
    elseif status == PreDownloadConstants.DownloadStatus.ResourceUpdateProgressing then
        self:SwitchProgressingStatus(params.downloadSize, params.totalSize, params.progress)
    elseif status == PreDownloadConstants.DownloadStatus.ResourceUpdateDecompressing then
        self:SwitchDecompressingStatus(params.progress)
    elseif status == PreDownloadConstants.DownloadStatus.ResourceUpdateError then
        self:SwitchErrorStatus(params.error)
    elseif status == PreDownloadConstants.DownloadStatus.ResourceUpdateDone then
        self:SwitchDownloadDoneStatus()
    elseif status == PreDownloadConstants.DownloadStatus.Finish then
        self:SwitchFinishStatus()
    elseif status == PreDownloadConstants.DownloadStatus.DownloadSpaceNotEnough then
        self:SpaceNotEnough(params)
    end
end

function ThirdPackageDownloadDialog:SwitchDefaultStatus()
    --KTool.SetActive(self.BtnClose.gameObject , false)
    KTool.SetActive(self.UpdateBottom1.gameObject , false)
    CfUtils.SetSliderPercent(self.Slider , 0)
    CfUtils.FillText(self.TextNum , '')
    CfUtils.FillText(self.ProText , '0%')
    CfUtils.FillText(self.TitleText ,localize("正在下载"))
end


---切换下载完成状态
function ThirdPackageDownloadDialog:SwitchFinishStatus()
    KTool.SetActive(self.BtnClose.gameObject , true) 
    KTool.SetActive(self.UpdateBottom1.gameObject , false)
    KTool.SetActive(self.UpdateBottom2.gameObject ,false)
    GameUtils.Toast(localize('下载完成'))
end
function ThirdPackageDownloadDialog:SwitchStartStatus()
    KTool.SetActive(self.UpdateBottom1 ,false)
    KTool.SetActive(self.UpdateBottom2 ,true)
    CfUtils.FillText(self.TitleText, localize("开始下载"))
    CfUtils.SetSliderPercent(self.Slider ,"0" )
    CfUtils.SetSliderPercent(self.ProText ,"0%")
end

---切换下载状态
---@param downloadSize number 已下载的大小
---@param totalSize    number 总大小
---@param progress     number 进度
---@param speed     number 速度
function ThirdPackageDownloadDialog:SpaceNotEnough(param)
    local downloadInfo = param.downloadInfo
    local availableSize =  checkInt(downloadInfo.availableSize)
    local downloadNeedSize =  checkInt(downloadInfo.downloadNeedSize)
    CfUtils.FillText(self.TitleText , localize("(当前储存空间不足,还需要_num_)",{_num_ = Utils.HumanReadableBytes(downloadNeedSize - availableSize) })) 
end

---切换下载状态
---@param downloadSize number 已下载的大小
---@param totalSize    number 总大小
---@param progress     number 进度
---@param speed     number 速度
function ThirdPackageDownloadDialog:SwitchProgressingStatus(downloadSize, totalSize, progress, speed)
    CfUtils.SetSliderPercent(self.Slider, progress)
    CfUtils.FillText(self.ProText, string.format('%.2f%%', progress * 100))
    if not isNull(speed) then
        CfUtils.FillText(self.TextNum, string.format("(%s/%s) (%s/s)", Utils.HumanReadableBytes(downloadSize), Utils.HumanReadableBytes(totalSize), Utils.HumanReadableBytes(speed)))
    else
        CfUtils.FillText(self.TextNum, string.format("(%s/%s)", Utils.HumanReadableBytes(downloadSize), Utils.HumanReadableBytes(totalSize)))
    end
    
end
function ThirdPackageDownloadDialog:SwitchMargeStatus(downloadSize, totalSize, progress)
    KTool.SetActive(self.TextNum.gameObject ,false)
    --- 兼容新老sdk写法如下
    CfUtils.FillText(self.TitleText, localize("文件校验中，请耐心等待..."))
end
function ThirdPackageDownloadDialog:SwitchCheckStatus()
    KTool.SetActive(self.TextNum.gameObject ,false)
    --- 兼容新老sdk写法如下
    CfUtils.FillText(self.TxtState, localize("文件合并中，请耐心等待..."))
end

function ThirdPackageDownloadDialog:SwitchCheckPrograssStatus(percent)
    CfUtils.SetSliderPercent(self.Slider, checkInt(percent * 10) / 1000)
    CfUtils.FillText(self.ProText, string.format('%.2f%%', percent))
    CfUtils.FillText(self.TextNum, "")
end

function ThirdPackageDownloadDialog:SwitchErrorStatus(error)
    CfUtils.FillText(self.TitleText, error)
end
---切换下载完成状态
function ThirdPackageDownloadDialog:SwitchDownloadDoneStatus()
    CfUtils.FillText(self.TitleText, '')
    CfUtils.FillText(self.ProText, '100%')
    CfUtils.SetSliderPercent(self.Slider, 100)
    CfUtils.FillText(self.TitleText, localize("下载完成"))
end
---切换解压中状态
---@param progress     number 进度
function ThirdPackageDownloadDialog:SwitchDecompressingStatus(progress)
    CfUtils.FillText(self.TitleText, '')
    CfUtils.FillText(self.TextNum, "")
    CfUtils.SetSliderPercent(self.Slider, progress)
    CfUtils.FillText(self.ProText, string.format('%.2f%%', progress * 100))
    CfUtils.FillText(self.TitleText, localize("资源解压中"))
end

--region handler
---下载状态事件处理
function ThirdPackageDownloadDialog:DownStatusEventHandler(params)
    self._downloadStatus = params.status
    self:SwitchStatus(params.status, params)
end
---切换开始下载热更新状态
function ThirdPackageDownloadDialog:SwitchResourceUpdateStartStatus()
    CfUtils.SetSliderPercent(self.Slider, 0)
    CfUtils.FillText(self.ProText, "0%")
    CfUtils.FillText(self.TextNum, '')
    CfUtils.FillText(self.TitleText, localize("资源获取中"))
end

function ThirdPackageDownloadDialog:__delete()
    self.configs = nil
end

---GetCurrentJobLevel
---获取当前职级
function ThirdPackageDownloadDialog:GetCurrentJobLevel()
    local point = GoodsUtils.GetThingNo(self:GetParam(ParamDefine.GOOD_ID))
    local curLevel = 1
    local config = {}
    for i, v in pairs(self.configs) do
        if checkNumber(point) >= checkNumber(v.point) then
            curLevel = checkNumber(v.id)
            config = v
        end
    end
    return curLevel, config
end


function ThirdPackageDownloadDialog:Awake()
    self.handler = Events.AddListener("DownloadStatus", Bind(self, self.DownStatusEventHandler))
    ---@type TableML.TableFile
    local tableFile = CfUtils.GetCfTable(AutoIds.IdSetting6511)
    self.configs = {}
    for i, row in pairs(tableFile) do
        local id = checkNumber(row:Get("id"))
        local name = parse_localizeText(row, "name")
        local point = checkNumber(row:Get("point"))
        local rewardNum = checkNumber(row:Get("rewardNum"))
        table.insert(self.configs, {
            id = id,
            name = name,
            point = point,
            num = rewardNum,
        })
    end
end
function ThirdPackageDownloadDialog:GetParam(id)
    ---@type ParamsVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6512, "Activity.ContractOfFood.Annihilation.ParamsVo", id)
    return checkNumber(vo.num)
end

function ThirdPackageDownloadDialog:InitUI()
    local id, config = self:GetCurrentJobLevel()
    local num = self:GetParam(ParamDefine.MONTHLY_DELTA)
    local goodsId = self:GetParam(ParamDefine.REWARD_GOOD_ID)
    CfUtils.FillText(self.LowTxtName, config.name)
    CfUtils.FillImage(self.LowImgGoods , GoodsUtils.GetGoodsIconById(goodsId))
    CfUtils.FillText(self.LowTxtNum ,checkNumber(config.num) * num)

    local count = #self.configs
    local highConfig = self.configs[count]
    CfUtils.FillText(self.HighTxtName, config.name)
    CfUtils.FillImage(self.HighImgGoods , GoodsUtils.GetGoodsIconById(goodsId))
    CfUtils.FillText(self.HighTxtNum ,checkNumber(highConfig.num) * num)
end

function ThirdPackageDownloadDialog:UpdateBottomUI(downloadBeforeInfo )
    local MainThirdDownload =  ThirdDownloadManager:IsOpenDownloadMain()
    local version =  CS.UnityEngine.Application.version 
    local thirdVersion = PlayerPrefsUtility.GetEncryptedString(ThirdPackageDownloaded, "")
    if version == thirdVersion then
        KTool.SetActive(self.UpdateBottom1 , false) 
        KTool.SetActive(self.UpdateBottom2, true) 
        self:SwitchFinishStatus()
        return
    end
    if MainThirdDownload then
        KTool.SetActive(self.UpdateBottom1 , false) 
        KTool.SetActive(self.UpdateBottom2, true) 
    else
        local thirdStruct = ThirdDownloadManager:GetDownloadThirdPackage(downloadBeforeInfo)    
        local totalZipSize = checkInt(thirdStruct.totalZipSize) 
        CfUtils.FillText(self.TxtNumber, string.format("%s", Utils.HumanReadableBytes(totalZipSize)))
        KTool.SetActive(self.UpdateBottom1 , true) 
        KTool.SetActive(self.UpdateBottom2, false) 
    end
end

function ThirdPackageDownloadDialog:OnInitialize()
    return CoWaitDo(function()
        SetButtonAction(self.BtnClose , function ()
            UIModule.BackDialog(self.controller)
        end)
        SetButtonAction(self.BtnMagnifier , function ()
            local id, config = self:GetCurrentJobLevel()
            CfUtils.DialogOpen(Constants.UITypeIds.SalaryPlanPopup, { delta = self:GetParam(ParamDefine.MONTHLY_DELTA), config = config })
        end)
      
        local preVersion = PlayerPrefsUtility.GetEncryptedString(SmallPackageDownloaded, "")
        if string.isEmpty(preVersion) then
            preVersion = CS.UnityEngine.Application.version
        end
        local thirdVersion = PlayerPrefsUtility.GetEncryptedString(ThirdPackageDownloaded, "")
        if not string.isEmpty(thirdVersion) then
            preVersion = preVersion .. ";" .. thirdVersion
        end
        CfUtils.SetColorString(self.TextNum , "#FFFFFF")
        if CS.UnityEngine.Application.version ~= thirdVersion then
            GameUtils.Request("User/downloadBefore", { preVersion = preVersion }, function(request, response)
                if checkNumber(response.errCode) == 0 then
                    self.downloadBeforeInfo = checkTable(response.data)
                    local initParams = self.controller.Argument.parameters or {}
                    SetButtonAction(self.ButtonGroup, function ()
                        ThirdDownloadManager:MainThirdDownload(self.downloadBeforeInfo)
                    end)
                    self:UpdateBottomUI(self.downloadBeforeInfo)    
                end 
            end)    
        end
        self:InitUI()
    end)
end


function ThirdPackageDownloadDialog:OnFinalize()
    return CoWaitDo(function()
        if isNotNull(self.handler) then
            Events.RemoveListener("DownloadStatus", self.handler)
            self.handler = nil
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ThirdPackageDownloadDialog
