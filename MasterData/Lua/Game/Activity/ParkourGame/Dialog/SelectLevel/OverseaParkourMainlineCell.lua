---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")

local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Color = CS.UnityEngine.Color


local BehaviourAction = CS.Engine.Lib.BehaviourAction


-- ====================================================== 
-- 选择关卡里, 每个 ui泡泡


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainlineCell12001801.prefab > name: OverseaParkourMainlineCell12001801
---@class OverseaParkourMainlineCell
---@field Env                           	OverseaParkourMainlineCell              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Story                         	UnityEngine.RectTransform               	@ 0    剧情
---@field Battle                        	UnityEngine.RectTransform               	@ 1    战斗 (可能: 剧情+战斗)
---@field Parkour                       	UnityEngine.RectTransform               	@ 2    跑酷
---@field Finish                        	UnityEngine.RectTransform               	@ 3    已通关
---@field StarLevel                     	UnityEngine.RectTransform               	@ 4    
---@field Lock                          	UnityEngine.RectTransform               	@ 5    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 6    背景图 - 未锁定
---@field ImgBgLock                     	UnityEngine.RectTransform               	@ 7    背景图 - 锁定
---@field Root                          	UnityEngine.RectTransform               	@ 8    
---@field Information                   	UnityEngine.RectTransform               	@ 9    黄色箭头
---@field InfoName                      	UnityEngine.RectTransform               	@ 10   
local OverseaParkourMainlineCell = Class("OverseaParkourMainlineCell")
-- 外部访问时:
-- local OverseaParkourMainlineCell = import("Game.Activity.ParkourGame.Dialog.SelectLevel.OverseaParkourMainlineCell")


---@class OverseaParkourMainlineCell.InputData
---@param levelType ParkourGameUtil.LevelType
---@param isLocked  boolean
---@param isFinish  boolean
---@param starTask   table


-- ======================================================

local anim_Default = "OverseaParkourMainlineCell_Default"
local anim_Select = "OverseaParkourMainlineCell_Select"



-- ======================================================

function OverseaParkourMainlineCell:__init()
    self.controller = nil
    self.rate = Mathf.PI/(311 * 2)
end

function OverseaParkourMainlineCell:__delete()
    self.controller = nil
end


function OverseaParkourMainlineCell:Awake()
    local behaviourAction = CfUtils.GetOrAddComponent(self.controller,typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = Bind(self,self.Update)
    end
    self.transform = self.controller.transform
    self.animRoot = self.transform:Find("AnimRoot")
    self.BtnNode = self.animRoot:Find("BtnNode")
    self.ImgSelect = self.Root:Find("ImgSelect")
    --- 
    local ImgStar1 = self.StarLevel:Find("ImgStar1")
    local ImgStar2 = self.StarLevel:Find("ImgStar2")
    local ImgStar3 = self.StarLevel:Find("ImgStar3")  
    self.ImgStars = { ImgStar1, ImgStar2, ImgStar3 }

    -- 黄色小箭头, 标题等
    self.info = {
        arrow = self.Information:Find("ImgArrow"),
        nameBg = self.InfoName:Find("ImgBg"),
        nameText = self.InfoName:Find("TextDesc"),
    }
end

---@param inData OverseaParkourMainlineCell.InputData
function OverseaParkourMainlineCell:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaParkourMainlineCell:RefreshUI()

    CfUtils.SetActive( self.InfoName.gameObject, self.inData.isCurrentLevel )
    if self.inData.isCurrentLevel then 
        self:PlayAnim_Select()
    else 
        self:PlayAnim_Default()
    end 


    self:DrawArrow()


    CfUtils.SetActive(self.ImgSelect.gameObject, false)
    CfUtils.SetActive( self.Parkour.gameObject, self.inData.levelType == ParkourGameUtil.LevelType.Parkour )
    CfUtils.SetActive( self.Story.gameObject, self.inData.levelType == ParkourGameUtil.LevelType.Story )
    CfUtils.SetActive( self.Battle.gameObject, self.inData.levelType == ParkourGameUtil.LevelType.Battle )
    ---
    CfUtils.SetActive( self.Lock.gameObject, self.inData.isLocked == true )
    CfUtils.SetActive( self.ImgBg.gameObject, self.inData.isLocked == false )
    CfUtils.SetActive( self.ImgBgLock.gameObject, self.inData.isLocked == true )
    ---
    CfUtils.SetActive( self.StarLevel.gameObject, self.inData.levelType == ParkourGameUtil.LevelType.Parkour)
    if self.inData.levelType == ParkourGameUtil.LevelType.Parkour then 
        for i=1,3 do 
            local task = self.inData.starTask[i]
            CfUtils.SetUISwitchImage( self.ImgStars[i].gameObject, task.status > 0 and 2 or 1 )
        end
    else 
        CfUtils.SetActive( self.Finish.gameObject, self.inData.isFinish == true )
    end 
end



function OverseaParkourMainlineCell:DrawArrow()

    local isCurrentLevel = self.inData.isCurrentLevel

    CfUtils.SetActive(self.Information.gameObject, isCurrentLevel)

    -- 绘制名字:
    --local titleDatas = string.split( self.inData.mainlineVo.name, " " )
    --CfUtils.FillText( self.info.nameText.gameObject, titleDatas[2] )
    CfUtils.FillText( self.info.nameText.gameObject, tostring(self.inData.mainlineVo.name) )
end



function OverseaParkourMainlineCell:Update()

    -- 简易曲线
     -- 旧版曲线效果
    local h = (self.inData.index0Based % 2 == 0) and 30 or -30
    local newY = -400 + h -- !! 这么写在异形屏适配上可能有问题...

    ---
    ParkourGameUtil._SetLocalPos( self.animRoot, nil, newY, 0 )

end



function OverseaParkourMainlineCell:PlayAnim_Select()
    CfUtils.PlayAnimation( self.animRoot.gameObject, anim_Select )
end

function OverseaParkourMainlineCell:PlayAnim_Default()
    CfUtils.PlayAnimation( self.animRoot.gameObject, anim_Default )
end



return OverseaParkourMainlineCell