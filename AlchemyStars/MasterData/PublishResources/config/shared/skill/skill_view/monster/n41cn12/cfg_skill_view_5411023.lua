LuaS �

xV           (w@_@../PublishResources/config/shared/skill/skill_view/monster/n41cn12/cfg_skill_view_5411023.lua         $   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � KB  JBD��@�� ��  A�  �� �A  � A� �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       &               effectIDListPARAM.RemoveEffect��       PlayCasterAnimation,animName = Skill04; PlayAudio,audioID =6017,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill04EffectId; PlayTargetAddBuff,buffID=50004; DataSelectDamage,damageIndex = 1; PlayEffectAtTargetPos,effectID=PARAM.Skill04HitEffectId; Wait,waitTime=4200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayTargetAddBuff,buffID=50001,remove=1; PlayTargetAddBuff,buffID=50002,remove=1; PlayCasterBindEffect,effectID=PARAM.Idle1EffectId; PlayCasterBindEffect,effectID=PARAM.Idle2EffectId; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=2500;         $                                                                                                                  key   $   config   $      _ENV