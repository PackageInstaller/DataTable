LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/trap/7777777/cfg_skill_view_583232.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterLegacyAnimation,animNames=eff_2800221_huode; PlayAudio,audioID = 8000,audioType=1; PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; Wait,waitTime=100; d       �DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1401,turnToTarget=1,deathClear=0, label=doAgain; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; 6ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1;         0                                                                                                                                                      key   0   config+   0      _ENV