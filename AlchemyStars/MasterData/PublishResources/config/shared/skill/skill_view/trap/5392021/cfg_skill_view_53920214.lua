LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/trap/5392021/cfg_skill_view_53920214.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 160216102,audioType=1; PlayCasterBindEffect,effectID =160218103; PlayCasterBindEffect,effectID =160218104; Wait,waitTime=5000;       �4       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1;         &                                                                                                                        key	   &   config!   &      _ENV