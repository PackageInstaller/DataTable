LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/trap/2800311/cfg_skill_view_49006403.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �=       PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; DataSelectDamage,damageIndex = 1; PlayCasterLegacyAnimation,animNames=eff_2800311_skill_main; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2658,turnToTarget=0,deathClear=0; Wait,waitTime=200; ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1; � DataSelectResult,effectType=79,index=1; PlayDestroyTrap; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,delay=0,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; Wait,waitTime=300;         %                                                                                                                     key   %   config    %      _ENV