LuaS �

xV           (w@W@../PublishResources/config/shared/skill/skill_view/season4/cfg_skill_view_8004003.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  � A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �,       DataSelectDamage,damageIndex = 1; Wait,waitTime=300; PlayCasterMaterialAnim,animName=eff_2900681_skill02; PlayAudio,audioID = 6123,audioType=1; Wait,waitTime=550; PlayCasterBindEffect,effectID=3126; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; Wait,waitTime=200; Wait,waitTime=300; PlaySummonTrap,trapID=8004013; PlaySummonTrap,trapID=8004014; PlaySummonTrap,trapID=8004015; PlaySummonTrap,trapID=8004016; DataSelectResult,effectType=120,index=1; PlayDestroyMonster; � Wait,waitTime=1050; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV