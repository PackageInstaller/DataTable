---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28


---@class MazeUI_Bubble
---@field IdleAnimationComp      UnityEngine.Animation -- 存储了 bubble 待机时的动画
local MazeUI_Bubble = Class('MazeUI_Bubble')



---:
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject


--- funtoy:
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local Vector3 = CS.UnityEngine.Vector3
local Animation = CS.UnityEngine.Animation


local MazeEventType = import('Game.Behaviours.Maze.MazeEventType')


local TypeID = 919 -- 用来写在 IDComp 组件上, 标识自己是个 bubble... 太tm简陋了



-- ========================================================


function MazeUI_Bubble:__init()
    self.controller = nil
end



function MazeUI_Bubble:__delete()
    self.controller = nil
    self.id = nil 
    self.eventType = nil
    self.gameObj = nil
end


function MazeUI_Bubble:Awake()
    KTool.SetActive(self.controller.gameObject, true);
end



function MazeUI_Bubble:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    --print("   ~~~~~~~ SimpleClass_2:OnDestroy() ~~~~~~~")
end


-- =============================================================== Self -> ================================================================== -- 



---@param info_ string, 如 "1-gear"  
function MazeUI_Bubble:SelfInit( info_ )
    assert( type(info_) == "string" )
    self.info = info_
    self.id, self.eventType = MazeUI_Bubble.StringToIdAndType(info_)

    assert( self.IdleAnimationComp )
    self.gameObj = self.controller.gameObject

    ---:
    self.PressedAnimationComp = KTool.GetComponent(self.gameObj, typeof(Animation))
    assert( self.PressedAnimationComp )
    self.pressedAnimationName = "UI_Common_ButtonPressed"

    ---:
    if self.eventType == MazeEventType.Get().Plot then 
        self.IdleAnimationName = "SpringFestivalMazeMachineBossNode_MachineBtn_ImgBubble1"

    elseif self.eventType == MazeEventType.Get().Gear then
        self.IdleAnimationName = "SpringFestivalMazeMachineBossNode_MachineBtn_ImgBubble2"
        
    elseif self.eventType == MazeEventType.Get().Chest then
        self.IdleAnimationName = "SpringFestivalMazeMachineBossNode_MachineBtn_ImgBubble2"

    elseif self.eventType == MazeEventType.Get().Boss then
        self.IdleAnimationName = "SpringFestivalMazeMachineBossNode_BossBtn"

    elseif self.eventType == MazeEventType.Get().Battle then
        self.IdleAnimationName = "SpringFestivalMazeMachineBossNode_BossBtn"

    else 
        assert( false, "类型错误" .. MazeEventType.ToString(self.eventType) )
    end

    -- 一直播放 待机动画:
    self.IdleAnimationComp:Play(self.IdleAnimationName)    
end



-- 当点击此 bubble 时, 需要播放一个动画
-- todo: 可成功播放 bubble 受击动画, 但是效果不明显, 暂时先没有调用它...
---@return integer
function MazeUI_Bubble:PlayBtnPressAnimation()
    self.PressedAnimationComp:Play(self.pressedAnimationName)
end



-- 用来写在 IDComp 组件上, 标识自己是个 bubble... 
---@return integer
function MazeUI_Bubble.GetTypeID()
    return TypeID
end


-- 检查参数 id 是不是属于本类型的...
---@return boolean
function MazeUI_Bubble.CheckTypeID( id )
    return (id == TypeID)
end


-- 得到类似: "1-gear" 
---@param id integer 
---@param type MazeEventType 
---@return string
function MazeUI_Bubble.ToString( id_, type_ )
    assert( type(id_) == "number", "id = " .. tostring(id_) )
    assert( not isNull(type_) )
    -- !!! 负数的 id 是否要特殊处理 ? 
    local s = tostring(id_) .. "-" .. MazeEventType.ToString(type_)
    return s
end


---@param info string
---@return integer, MazeEventType
function MazeUI_Bubble.StringToIdAndType( info )
    assert( type(info) == "string" )

    local ss = string.split( info, "-" )
    assert( #ss == 2 ) 
    
    local id = tonumber( ss[1] ) 
    local type_ = MazeEventType.StringToEventType( ss[2] )

    assert( (not isNull(id)) and (type(id) == "number") )
    assert( not isNull(type_) )
    return id, type_
end


return MazeUI_Bubble
