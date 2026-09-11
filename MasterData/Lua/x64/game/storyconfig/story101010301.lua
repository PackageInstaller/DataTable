return {
	Play101031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101031001
		arg_1_1.duration_ = 7.7

		local var_1_0 = {
			ja = 7.69933333333333,
			ko = 6.53333333333333,
			zh = 6.33333333333333,
			en = 6.93333333333333
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_fight_metal", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_5 = "B10a"

			if arg_1_1.bgs_.B10a == nil then
				local var_4_6 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_5)
				var_4_6.name = var_4_5
				var_4_6.transform.parent = arg_1_1.stage_.transform
				var_4_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_5] = var_4_6
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B10a:GetComponent("SpriteRenderer")

				if var_4_7 then
					arg_1_1.var_.alphaOldValueB10a = var_4_7.color.a
					arg_1_1.var_.alphaMatValueB10a = var_4_7
				end

				arg_1_1.var_.alphaOldValueB10a = 0
			end

			local var_4_8 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_8 then
				if arg_1_1.var_.alphaMatValueB10a then
					arg_1_1.var_.alphaMatValueB10a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB10a, 1, (arg_1_1.time_ - 0) / var_4_8)
					arg_1_1.var_.alphaMatValueB10a.color = arg_1_1.var_.alphaMatValueB10a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_8 and arg_1_1.time_ < 0 + var_4_8 + arg_4_0 and arg_1_1.var_.alphaMatValueB10a then
				arg_1_1.var_.alphaMatValueB10a.color.a = 1
				arg_1_1.var_.alphaMatValueB10a.color = arg_1_1.var_.alphaMatValueB10a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_9 = arg_1_1.bgs_.B10a

				arg_1_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_10 = var_4_9:GetComponent("SpriteRenderer")

				if var_4_10 and var_4_10.sprite then
					local var_4_11 = 2 * (var_4_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_9.transform.localScale = Vector3.New(var_4_11 / var_4_10.sprite.bounds.size.y < var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x and var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x or var_4_11 / var_4_10.sprite.bounds.size.y, var_4_11 / var_4_10.sprite.bounds.size.y < var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x and var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x or var_4_11 / var_4_10.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_12 = "1035ui_story"

			if arg_1_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_4_13 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_1_1.stage_.transform)

				var_4_13.name = var_4_12
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_12] = var_4_13

				local var_4_14 = var_4_13:GetComponentInChildren(typeof(CharacterEffect))

				var_4_14.enabled = true

				local var_4_15 = GameObjectTools.GetOrAddComponent(var_4_13, typeof(DynamicBoneHelper))

				if var_4_15 then
					var_4_15:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_14.transform, false)

				arg_1_1.var_[var_4_12 .. "Animator"] = var_4_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_12 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_12 .. "LipSync"] = var_4_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_16 = arg_1_1.actors_["1035ui_story"].transform

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.833333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1035ui_story = var_4_16.localPosition
			end

			local var_4_17 = 0.001

			if 0.833333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.833333333333333 + var_4_17 then
				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_1_1.time_ - 0.833333333333333) / var_4_17)
				var_4_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_16.position).x, (manager.ui.mainCamera.transform.position - var_4_16.position).y, (manager.ui.mainCamera.transform.position - var_4_16.position).z)
				var_4_16.localEulerAngles.z = 0
				var_4_16.localEulerAngles.x = 0
				var_4_16.localEulerAngles = var_4_16.localEulerAngles
			end

			if arg_1_1.time_ >= 0.833333333333333 + var_4_17 and arg_1_1.time_ < 0.833333333333333 + var_4_17 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(0, -1.05, -5.6)
				var_4_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_16.position).x, (manager.ui.mainCamera.transform.position - var_4_16.position).y, (manager.ui.mainCamera.transform.position - var_4_16.position).z)
				var_4_16.localEulerAngles.z = 0
				var_4_16.localEulerAngles.x = 0
				var_4_16.localEulerAngles = var_4_16.localEulerAngles
			end

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.833333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action7_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 0.833333333333333
			local var_4_19 = 0.5

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:GetWordFromCfg(101031001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 20 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 20)

				if (20 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 20)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031001", "story_v_out_101031.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_101031", "101031001", "story_v_out_101031.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_101031", "101031001", "story_v_out_101031.awb")

						arg_1_1:RecordAudio("101031001", var_4_26)
						arg_1_1:RecordAudio("101031001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101031", "101031001", "story_v_out_101031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101031", "101031001", "story_v_out_101031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play101031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101031002
		arg_8_1.duration_ = 7.8

		local var_8_0 = {
			ja = 7.8,
			ko = 5.466,
			zh = 7.133,
			en = 5.866
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play101031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story", "se_story_robot_broken", "")
			end

			local var_11_1 = "2044_tpose"

			if arg_8_1.actors_["2044_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2044_tpose"))) then
				local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "2044_tpose"), arg_8_1.stage_.transform)

				var_11_2.name = var_11_1
				var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_1] = var_11_2

				local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

				var_11_3.enabled = true

				local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

				if var_11_4 then
					var_11_4:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_3.transform, false)

				arg_8_1.var_[var_11_1 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_1 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_1 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_5 = arg_8_1.actors_["2044_tpose"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2044_tpose == nil then
				arg_8_1.var_.characterEffect2044_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect2044_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2044_tpose then
				arg_8_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_11_8 = arg_8_1.actors_["2044_tpose"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos2044_tpose = var_11_8.localPosition

				local var_11_9 = GameObjectTools.GetOrAddComponent(var_11_8.gameObject, typeof(DynamicBoneHelper))

				if var_11_9 then
					var_11_9:EnableDynamicBone(false)
				end
			end

			local var_11_10 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2044_tpose, Vector3.New(0, -1.15, -2.3), (arg_8_1.time_ - 0) / var_11_10)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0, -1.15, -2.3)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_8.gameObject, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("2044_tpose", "StoryTimeline/CharAction/story2044/story2044action/2044action1_1")
			end

			local var_11_12 = arg_8_1.actors_["1035ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1035ui_story = var_11_12.localPosition
			end

			local var_11_13 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_13 then
				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_13)
				var_11_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_12.position).x, (manager.ui.mainCamera.transform.position - var_11_12.position).y, (manager.ui.mainCamera.transform.position - var_11_12.position).z)
				var_11_12.localEulerAngles.z = 0
				var_11_12.localEulerAngles.x = 0
				var_11_12.localEulerAngles = var_11_12.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_13 and arg_8_1.time_ < 0 + var_11_13 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(0, 100, 0)
				var_11_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_12.position).x, (manager.ui.mainCamera.transform.position - var_11_12.position).y, (manager.ui.mainCamera.transform.position - var_11_12.position).z)
				var_11_12.localEulerAngles.z = 0
				var_11_12.localEulerAngles.x = 0
				var_11_12.localEulerAngles = var_11_12.localEulerAngles
			end

			local var_11_14 = 0
			local var_11_15 = 0.425

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_16 = arg_8_1:GetWordFromCfg(101031002)
				local var_11_17 = arg_8_1:FormatText(var_11_16.content)

				arg_8_1.text_.text = var_11_17

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 17 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 17)

				if (17 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 17)) > 0 and var_11_15 < var_11_19 then
					arg_8_1.talkMaxDuration = var_11_19

					if var_11_19 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_19 + var_11_14
					end
				end

				arg_8_1.text_.text = var_11_17
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031002", "story_v_out_101031.awb") ~= 0 then
					local var_11_20 = manager.audio:GetVoiceLength("story_v_out_101031", "101031002", "story_v_out_101031.awb") / 1000

					if var_11_20 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_14
					end

					if var_11_16.prefab_name ~= "" and arg_8_1.actors_[var_11_16.prefab_name] ~= nil then
						local var_11_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_16.prefab_name].transform, "story_v_out_101031", "101031002", "story_v_out_101031.awb")

						arg_8_1:RecordAudio("101031002", var_11_21)
						arg_8_1:RecordAudio("101031002", var_11_21)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101031", "101031002", "story_v_out_101031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101031", "101031002", "story_v_out_101031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_22 = math.max(var_11_15, arg_8_1.talkMaxDuration)

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_14) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_14 + var_11_22 and arg_8_1.time_ < var_11_14 + var_11_22 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play101031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101031003
		arg_12_1.duration_ = 8.2

		local var_12_0 = {
			ja = 8.2,
			ko = 4.366,
			zh = 5.7,
			en = 3.966
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play101031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["2044_tpose"]) and arg_12_1.var_.characterEffect2044_tpose == nil then
				arg_12_1.var_.characterEffect2044_tpose = arg_12_1.actors_["2044_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["2044_tpose"]) then
				if arg_12_1.var_.characterEffect2044_tpose and not isNil(arg_12_1.actors_["2044_tpose"]) then
					arg_12_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2044_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["2044_tpose"]) and arg_12_1.var_.characterEffect2044_tpose then
				arg_12_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2044_tpose.fillRatio = 0.5
			end

			local var_15_1 = arg_12_1.actors_["2044_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos2044_tpose = var_15_1.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_1.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 then
				var_15_1.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2044_tpose, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_3)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 then
				var_15_1.localPosition = Vector3.New(0, 100, 0)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_1.gameObject, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(true)
				end
			end

			local var_15_5 = arg_12_1.actors_["1035ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1035ui_story = var_15_5.localPosition
			end

			local var_15_6 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 then
				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_12_1.time_ - 0) / var_15_6)
				var_15_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_5.position).x, (manager.ui.mainCamera.transform.position - var_15_5.position).y, (manager.ui.mainCamera.transform.position - var_15_5.position).z)
				var_15_5.localEulerAngles.z = 0
				var_15_5.localEulerAngles.x = 0
				var_15_5.localEulerAngles = var_15_5.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, -1.05, -5.6)
				var_15_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_5.position).x, (manager.ui.mainCamera.transform.position - var_15_5.position).y, (manager.ui.mainCamera.transform.position - var_15_5.position).z)
				var_15_5.localEulerAngles.z = 0
				var_15_5.localEulerAngles.x = 0
				var_15_5.localEulerAngles = var_15_5.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action5_1")
			end

			local var_15_7 = 0
			local var_15_8 = 0.525

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:GetWordFromCfg(101031003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_12 = 21 <= 0 and var_15_8 or var_15_8 * (utf8.len(var_15_10) / 21)

				if (21 <= 0 and var_15_8 or var_15_8 * (utf8.len(var_15_10) / 21)) > 0 and var_15_8 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_7 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_7
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031003", "story_v_out_101031.awb") ~= 0 then
					local var_15_13 = manager.audio:GetVoiceLength("story_v_out_101031", "101031003", "story_v_out_101031.awb") / 1000

					if var_15_13 + var_15_7 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_7
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_101031", "101031003", "story_v_out_101031.awb")

						arg_12_1:RecordAudio("101031003", var_15_14)
						arg_12_1:RecordAudio("101031003", var_15_14)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101031", "101031003", "story_v_out_101031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101031", "101031003", "story_v_out_101031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_15 = math.max(var_15_8, arg_12_1.talkMaxDuration)

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_15 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_7) / var_15_15

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_7 + var_15_15 and arg_12_1.time_ < var_15_7 + var_15_15 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play101031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play101031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_19_0 = 0.300000011920929

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				local var_19_1, var_19_2 = math.modf((arg_16_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_19_2 * 0.13, var_19_2 * 0.13, var_19_2 * 0.13) + arg_16_1.var_.shakeOldPosMainCamera
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				manager.ui.mainCamera.transform.localPosition = arg_16_1.var_.shakeOldPosMainCamera
			end

			local var_19_3 = arg_16_1.actors_["1035ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1035ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, 100, 0)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = 0
			local var_19_6 = 0.525

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_7 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_7:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(101031004).content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 21 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_8) / 21)

				if (21 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_8) / 21)) > 0 and var_19_6 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10
					var_19_5 = var_19_5 + 0.3

					if var_19_10 + var_19_5 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_5
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = var_19_5 + 0.3
			local var_19_12 = math.max(var_19_6, arg_16_1.talkMaxDuration)

			if var_19_5 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_11 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_11) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_11 + var_19_12 and arg_16_1.time_ < var_19_11 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play101031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 101031005
		arg_22_1.duration_ = 6.27

		local var_22_0 = {
			ja = 4.9,
			ko = 5.5,
			zh = 4.433,
			en = 6.266
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play101031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_25_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_22_1.stage_.transform)

				var_25_0.name = "3008ui_story"
				var_25_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.actors_["3008ui_story"] = var_25_0

				local var_25_1 = var_25_0:GetComponentInChildren(typeof(CharacterEffect))

				var_25_1.enabled = true

				local var_25_2 = GameObjectTools.GetOrAddComponent(var_25_0, typeof(DynamicBoneHelper))

				if var_25_2 then
					var_25_2:EnableDynamicBone(false)
				end

				arg_22_1:ShowWeapon(var_25_1.transform, false)

				arg_22_1.var_["3008ui_story" .. "Animator"] = var_25_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_22_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_22_1.var_["3008ui_story" .. "LipSync"] = var_25_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_25_3 = arg_22_1.actors_["3008ui_story"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_3) and arg_22_1.var_.characterEffect3008ui_story == nil then
				arg_22_1.var_.characterEffect3008ui_story = var_25_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_4 = 0.1

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 and not isNil(var_25_3) then
				if arg_22_1.var_.characterEffect3008ui_story and not isNil(var_25_3) then
					arg_22_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 and not isNil(var_25_3) and arg_22_1.var_.characterEffect3008ui_story then
				arg_22_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_25_6 = arg_22_1.actors_["3008ui_story"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos3008ui_story = var_25_6.localPosition
			end

			local var_25_7 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				var_25_6.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos3008ui_story, Vector3.New(-0.7, -1.51, -4.3), (arg_22_1.time_ - 0) / var_25_7)
				var_25_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_6.position).x, (manager.ui.mainCamera.transform.position - var_25_6.position).y, (manager.ui.mainCamera.transform.position - var_25_6.position).z)
				var_25_6.localEulerAngles.z = 0
				var_25_6.localEulerAngles.x = 0
				var_25_6.localEulerAngles = var_25_6.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				var_25_6.localPosition = Vector3.New(-0.7, -1.51, -4.3)
				var_25_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_6.position).x, (manager.ui.mainCamera.transform.position - var_25_6.position).y, (manager.ui.mainCamera.transform.position - var_25_6.position).z)
				var_25_6.localEulerAngles.z = 0
				var_25_6.localEulerAngles.x = 0
				var_25_6.localEulerAngles = var_25_6.localEulerAngles
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_25_8 = 0
			local var_25_9 = 0.625

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_10 = arg_22_1:GetWordFromCfg(101031005)
				local var_25_11 = arg_22_1:FormatText(var_25_10.content)

				arg_22_1.text_.text = var_25_11

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 25 <= 0 and var_25_9 or var_25_9 * (utf8.len(var_25_11) / 25)

				if (25 <= 0 and var_25_9 or var_25_9 * (utf8.len(var_25_11) / 25)) > 0 and var_25_9 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_8
					end
				end

				arg_22_1.text_.text = var_25_11
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031005", "story_v_out_101031.awb") ~= 0 then
					local var_25_14 = manager.audio:GetVoiceLength("story_v_out_101031", "101031005", "story_v_out_101031.awb") / 1000

					if var_25_14 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_14 + var_25_8
					end

					if var_25_10.prefab_name ~= "" and arg_22_1.actors_[var_25_10.prefab_name] ~= nil then
						local var_25_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_10.prefab_name].transform, "story_v_out_101031", "101031005", "story_v_out_101031.awb")

						arg_22_1:RecordAudio("101031005", var_25_15)
						arg_22_1:RecordAudio("101031005", var_25_15)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_101031", "101031005", "story_v_out_101031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_101031", "101031005", "story_v_out_101031.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_16 = math.max(var_25_9, arg_22_1.talkMaxDuration)

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_16 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_8) / var_25_16

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_8 + var_25_16 and arg_22_1.time_ < var_25_8 + var_25_16 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play101031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 101031006
		arg_26_1.duration_ = 2.1

		local var_26_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play101031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["3008ui_story"]) and arg_26_1.var_.characterEffect3008ui_story == nil then
				arg_26_1.var_.characterEffect3008ui_story = arg_26_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.1

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["3008ui_story"]) then
				if arg_26_1.var_.characterEffect3008ui_story and not isNil(arg_26_1.actors_["3008ui_story"]) then
					arg_26_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_26_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_0)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["3008ui_story"]) and arg_26_1.var_.characterEffect3008ui_story then
				arg_26_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_26_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_29_1 = arg_26_1.actors_["1035ui_story"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1035ui_story = var_29_1.localPosition
			end

			local var_29_2 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_2 then
				var_29_1.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_26_1.time_ - 0) / var_29_2)
				var_29_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_1.position).x, (manager.ui.mainCamera.transform.position - var_29_1.position).y, (manager.ui.mainCamera.transform.position - var_29_1.position).z)
				var_29_1.localEulerAngles.z = 0
				var_29_1.localEulerAngles.x = 0
				var_29_1.localEulerAngles = var_29_1.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_2 and arg_26_1.time_ < 0 + var_29_2 + arg_29_0 then
				var_29_1.localPosition = Vector3.New(0.7, -1.05, -5.6)
				var_29_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_1.position).x, (manager.ui.mainCamera.transform.position - var_29_1.position).y, (manager.ui.mainCamera.transform.position - var_29_1.position).z)
				var_29_1.localEulerAngles.z = 0
				var_29_1.localEulerAngles.x = 0
				var_29_1.localEulerAngles = var_29_1.localEulerAngles
			end

			local var_29_3 = arg_26_1.actors_["3008ui_story"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos3008ui_story = var_29_3.localPosition
			end

			local var_29_4 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				var_29_3.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos3008ui_story, Vector3.New(-0.7, -1.51, -4.3), (arg_26_1.time_ - 0) / var_29_4)
				var_29_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_3.position).x, (manager.ui.mainCamera.transform.position - var_29_3.position).y, (manager.ui.mainCamera.transform.position - var_29_3.position).z)
				var_29_3.localEulerAngles.z = 0
				var_29_3.localEulerAngles.x = 0
				var_29_3.localEulerAngles = var_29_3.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				var_29_3.localPosition = Vector3.New(-0.7, -1.51, -4.3)
				var_29_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_3.position).x, (manager.ui.mainCamera.transform.position - var_29_3.position).y, (manager.ui.mainCamera.transform.position - var_29_3.position).z)
				var_29_3.localEulerAngles.z = 0
				var_29_3.localEulerAngles.x = 0
				var_29_3.localEulerAngles = var_29_3.localEulerAngles
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action3_2")
			end

			local var_29_5 = arg_26_1.actors_["1035ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_5) and arg_26_1.var_.characterEffect1035ui_story == nil then
				arg_26_1.var_.characterEffect1035ui_story = var_29_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_6 = 0.1

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_6 and not isNil(var_29_5) then
				if arg_26_1.var_.characterEffect1035ui_story and not isNil(var_29_5) then
					arg_26_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_6 and arg_26_1.time_ < 0 + var_29_6 + arg_29_0 and not isNil(var_29_5) and arg_26_1.var_.characterEffect1035ui_story then
				arg_26_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_29_8 = 0
			local var_29_9 = 0.1

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_10 = arg_26_1:GetWordFromCfg(101031006)
				local var_29_11 = arg_26_1:FormatText(var_29_10.content)

				arg_26_1.text_.text = var_29_11

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 4 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 4)

				if (4 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 4)) > 0 and var_29_9 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_8
					end
				end

				arg_26_1.text_.text = var_29_11
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031006", "story_v_out_101031.awb") ~= 0 then
					local var_29_14 = manager.audio:GetVoiceLength("story_v_out_101031", "101031006", "story_v_out_101031.awb") / 1000

					if var_29_14 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_14 + var_29_8
					end

					if var_29_10.prefab_name ~= "" and arg_26_1.actors_[var_29_10.prefab_name] ~= nil then
						local var_29_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_10.prefab_name].transform, "story_v_out_101031", "101031006", "story_v_out_101031.awb")

						arg_26_1:RecordAudio("101031006", var_29_15)
						arg_26_1:RecordAudio("101031006", var_29_15)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_101031", "101031006", "story_v_out_101031.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_101031", "101031006", "story_v_out_101031.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_16 = math.max(var_29_9, arg_26_1.talkMaxDuration)

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_16 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_8) / var_29_16

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_8 + var_29_16 and arg_26_1.time_ < var_29_8 + var_29_16 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play101031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 101031007
		arg_30_1.duration_ = 10.27

		local var_30_0 = {
			ja = 10.266,
			ko = 7.3,
			zh = 5.233,
			en = 6.366
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play101031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["3008ui_story"]) and arg_30_1.var_.characterEffect3008ui_story == nil then
				arg_30_1.var_.characterEffect3008ui_story = arg_30_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.1

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["3008ui_story"]) then
				if arg_30_1.var_.characterEffect3008ui_story and not isNil(arg_30_1.actors_["3008ui_story"]) then
					arg_30_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["3008ui_story"]) and arg_30_1.var_.characterEffect3008ui_story then
				arg_30_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_33_2 = arg_30_1.actors_["1035ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.characterEffect1035ui_story == nil then
				arg_30_1.var_.characterEffect1035ui_story = var_33_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_3 = 0.1

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_3 and not isNil(var_33_2) then
				if arg_30_1.var_.characterEffect1035ui_story and not isNil(var_33_2) then
					arg_30_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_3)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_3 and arg_30_1.time_ < 0 + var_33_3 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.characterEffect1035ui_story then
				arg_30_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_2")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_33_4 = 0
			local var_33_5 = 0.625

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(101031007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 25 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 25)

				if (25 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 25)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031007", "story_v_out_101031.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_101031", "101031007", "story_v_out_101031.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_out_101031", "101031007", "story_v_out_101031.awb")

						arg_30_1:RecordAudio("101031007", var_33_11)
						arg_30_1:RecordAudio("101031007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_101031", "101031007", "story_v_out_101031.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_101031", "101031007", "story_v_out_101031.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play101031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 101031008
		arg_34_1.duration_ = 8.47

		local var_34_0 = {
			ja = 7.333,
			ko = 7.6,
			zh = 5.433,
			en = 8.466
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play101031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_37_0 = 0
			local var_37_1 = 0.825

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_2 = arg_34_1:GetWordFromCfg(101031008)
				local var_37_3 = arg_34_1:FormatText(var_37_2.content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 33 <= 0 and var_37_1 or var_37_1 * (utf8.len(var_37_3) / 33)

				if (33 <= 0 and var_37_1 or var_37_1 * (utf8.len(var_37_3) / 33)) > 0 and var_37_1 < var_37_5 then
					arg_34_1.talkMaxDuration = var_37_5

					if var_37_5 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031008", "story_v_out_101031.awb") ~= 0 then
					local var_37_6 = manager.audio:GetVoiceLength("story_v_out_101031", "101031008", "story_v_out_101031.awb") / 1000

					if var_37_6 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_0
					end

					if var_37_2.prefab_name ~= "" and arg_34_1.actors_[var_37_2.prefab_name] ~= nil then
						local var_37_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_2.prefab_name].transform, "story_v_out_101031", "101031008", "story_v_out_101031.awb")

						arg_34_1:RecordAudio("101031008", var_37_7)
						arg_34_1:RecordAudio("101031008", var_37_7)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_101031", "101031008", "story_v_out_101031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_101031", "101031008", "story_v_out_101031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_8 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_8 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_8

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_8 and arg_34_1.time_ < var_37_0 + var_37_8 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play101031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 101031009
		arg_38_1.duration_ = 3.57

		local var_38_0 = {
			ja = 3.566,
			ko = 1.999999999999,
			zh = 2.333,
			en = 3.3
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play101031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["3008ui_story"]) and arg_38_1.var_.characterEffect3008ui_story == nil then
				arg_38_1.var_.characterEffect3008ui_story = arg_38_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.1

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["3008ui_story"]) then
				if arg_38_1.var_.characterEffect3008ui_story and not isNil(arg_38_1.actors_["3008ui_story"]) then
					arg_38_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_38_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["3008ui_story"]) and arg_38_1.var_.characterEffect3008ui_story then
				arg_38_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_38_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_1")
			end

			local var_41_1 = arg_38_1.actors_["1035ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect1035ui_story == nil then
				arg_38_1.var_.characterEffect1035ui_story = var_41_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.100000001490116

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_2 and not isNil(var_41_1) then
				if arg_38_1.var_.characterEffect1035ui_story and not isNil(var_41_1) then
					arg_38_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_2 and arg_38_1.time_ < 0 + var_41_2 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect1035ui_story then
				arg_38_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_41_4 = 0
			local var_41_5 = 0.2

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(101031009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 8 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 8)

				if (8 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 8)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031009", "story_v_out_101031.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_101031", "101031009", "story_v_out_101031.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_101031", "101031009", "story_v_out_101031.awb")

						arg_38_1:RecordAudio("101031009", var_41_11)
						arg_38_1:RecordAudio("101031009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_101031", "101031009", "story_v_out_101031.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_101031", "101031009", "story_v_out_101031.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play101031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 101031010
		arg_42_1.duration_ = 3.37

		local var_42_0 = {
			ja = 3.366,
			ko = 2.3,
			zh = 2.466,
			en = 3.3
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play101031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_45_0 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_42_1.stage_.transform)

				var_45_0.name = "2020_tpose"
				var_45_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.actors_["2020_tpose"] = var_45_0

				local var_45_1 = var_45_0:GetComponentInChildren(typeof(CharacterEffect))

				var_45_1.enabled = true

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end

				arg_42_1:ShowWeapon(var_45_1.transform, false)

				arg_42_1.var_["2020_tpose" .. "Animator"] = var_45_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_42_1.var_["2020_tpose" .. "Animator"].applyRootMotion = true
				arg_42_1.var_["2020_tpose" .. "LipSync"] = var_45_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_45_3 = arg_42_1.actors_["2020_tpose"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect2020_tpose == nil then
				arg_42_1.var_.characterEffect2020_tpose = var_45_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.1

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_3) then
				if arg_42_1.var_.characterEffect2020_tpose and not isNil(var_45_3) then
					arg_42_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect2020_tpose then
				arg_42_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_45_6 = arg_42_1.actors_["3008ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos3008ui_story = var_45_6.localPosition
			end

			local var_45_7 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				var_45_6.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos3008ui_story, Vector3.New(-0.7, -1.51, -4.3), (arg_42_1.time_ - 0) / var_45_7)
				var_45_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_6.position).x, (manager.ui.mainCamera.transform.position - var_45_6.position).y, (manager.ui.mainCamera.transform.position - var_45_6.position).z)
				var_45_6.localEulerAngles.z = 0
				var_45_6.localEulerAngles.x = 0
				var_45_6.localEulerAngles = var_45_6.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				var_45_6.localPosition = Vector3.New(-0.7, -1.51, -4.3)
				var_45_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_6.position).x, (manager.ui.mainCamera.transform.position - var_45_6.position).y, (manager.ui.mainCamera.transform.position - var_45_6.position).z)
				var_45_6.localEulerAngles.z = 0
				var_45_6.localEulerAngles.x = 0
				var_45_6.localEulerAngles = var_45_6.localEulerAngles
			end

			local var_45_8 = arg_42_1.actors_["2020_tpose"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos2020_tpose = var_45_8.localPosition

				local var_45_9 = GameObjectTools.GetOrAddComponent(var_45_8.gameObject, typeof(DynamicBoneHelper))

				if var_45_9 then
					var_45_9:EnableDynamicBone(false)
				end
			end

			local var_45_10 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_10 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos2020_tpose, Vector3.New(0.7, -1.2, -4.1), (arg_42_1.time_ - 0) / var_45_10)
				var_45_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_8.position).x, (manager.ui.mainCamera.transform.position - var_45_8.position).y, (manager.ui.mainCamera.transform.position - var_45_8.position).z)
				var_45_8.localEulerAngles.z = 0
				var_45_8.localEulerAngles.x = 0
				var_45_8.localEulerAngles = var_45_8.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_10 and arg_42_1.time_ < 0 + var_45_10 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(0.7, -1.2, -4.1)
				var_45_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_8.position).x, (manager.ui.mainCamera.transform.position - var_45_8.position).y, (manager.ui.mainCamera.transform.position - var_45_8.position).z)
				var_45_8.localEulerAngles.z = 0
				var_45_8.localEulerAngles.x = 0
				var_45_8.localEulerAngles = var_45_8.localEulerAngles

				local var_45_11 = GameObjectTools.GetOrAddComponent(var_45_8.gameObject, typeof(DynamicBoneHelper))

				if var_45_11 then
					var_45_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_45_12 = arg_42_1.actors_["1035ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1035ui_story = var_45_12.localPosition
			end

			local var_45_13 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_13 then
				var_45_12.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_42_1.time_ - 0) / var_45_13)
				var_45_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_12.position).x, (manager.ui.mainCamera.transform.position - var_45_12.position).y, (manager.ui.mainCamera.transform.position - var_45_12.position).z)
				var_45_12.localEulerAngles.z = 0
				var_45_12.localEulerAngles.x = 0
				var_45_12.localEulerAngles = var_45_12.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_13 and arg_42_1.time_ < 0 + var_45_13 + arg_45_0 then
				var_45_12.localPosition = Vector3.New(0, 100, 0)
				var_45_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_12.position).x, (manager.ui.mainCamera.transform.position - var_45_12.position).y, (manager.ui.mainCamera.transform.position - var_45_12.position).z)
				var_45_12.localEulerAngles.z = 0
				var_45_12.localEulerAngles.x = 0
				var_45_12.localEulerAngles = var_45_12.localEulerAngles
			end

			local var_45_14 = 0
			local var_45_15 = 0.3

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_16 = arg_42_1:GetWordFromCfg(101031010)
				local var_45_17 = arg_42_1:FormatText(var_45_16.content)

				arg_42_1.text_.text = var_45_17

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_19 = 12 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 12)

				if (12 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 12)) > 0 and var_45_15 < var_45_19 then
					arg_42_1.talkMaxDuration = var_45_19

					if var_45_19 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_14
					end
				end

				arg_42_1.text_.text = var_45_17
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031010", "story_v_out_101031.awb") ~= 0 then
					local var_45_20 = manager.audio:GetVoiceLength("story_v_out_101031", "101031010", "story_v_out_101031.awb") / 1000

					if var_45_20 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_20 + var_45_14
					end

					if var_45_16.prefab_name ~= "" and arg_42_1.actors_[var_45_16.prefab_name] ~= nil then
						local var_45_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_16.prefab_name].transform, "story_v_out_101031", "101031010", "story_v_out_101031.awb")

						arg_42_1:RecordAudio("101031010", var_45_21)
						arg_42_1:RecordAudio("101031010", var_45_21)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_101031", "101031010", "story_v_out_101031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_101031", "101031010", "story_v_out_101031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_22 = math.max(var_45_15, arg_42_1.talkMaxDuration)

			if var_45_14 <= arg_42_1.time_ and arg_42_1.time_ < var_45_14 + var_45_22 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_14) / var_45_22

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_14 + var_45_22 and arg_42_1.time_ < var_45_14 + var_45_22 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play101031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 101031011
		arg_46_1.duration_ = 3.27

		local var_46_0 = {
			ja = 3.266,
			ko = 1.233,
			zh = 1.2,
			en = 1.366
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play101031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.1

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(101031011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 4 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 4)

				if (4 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 4)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031011", "story_v_out_101031.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_101031", "101031011", "story_v_out_101031.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_101031", "101031011", "story_v_out_101031.awb")

						arg_46_1:RecordAudio("101031011", var_49_6)
						arg_46_1:RecordAudio("101031011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_101031", "101031011", "story_v_out_101031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_101031", "101031011", "story_v_out_101031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play101031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 101031012
		arg_50_1.duration_ = 6.27

		local var_50_0 = {
			ja = 6.266,
			ko = 4.733,
			zh = 3.866,
			en = 5.2
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play101031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["3008ui_story"]) and arg_50_1.var_.characterEffect3008ui_story == nil then
				arg_50_1.var_.characterEffect3008ui_story = arg_50_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["3008ui_story"]) then
				if arg_50_1.var_.characterEffect3008ui_story and not isNil(arg_50_1.actors_["3008ui_story"]) then
					arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["3008ui_story"]) and arg_50_1.var_.characterEffect3008ui_story then
				arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_53_2 = arg_50_1.actors_["2020_tpose"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect2020_tpose == nil then
				arg_50_1.var_.characterEffect2020_tpose = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_3 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.characterEffect2020_tpose and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_50_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_3)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect2020_tpose then
				arg_50_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_50_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_53_4 = 0
			local var_53_5 = 0.5

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(101031012)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 20 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 20)

				if (20 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 20)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031012", "story_v_out_101031.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_101031", "101031012", "story_v_out_101031.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_out_101031", "101031012", "story_v_out_101031.awb")

						arg_50_1:RecordAudio("101031012", var_53_11)
						arg_50_1:RecordAudio("101031012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_101031", "101031012", "story_v_out_101031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_101031", "101031012", "story_v_out_101031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play101031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 101031013
		arg_54_1.duration_ = 10.33

		local var_54_0 = {
			ja = 10.333,
			ko = 4.5,
			zh = 5.3,
			en = 7.133
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play101031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["2020_tpose"]) and arg_54_1.var_.characterEffect2020_tpose == nil then
				arg_54_1.var_.characterEffect2020_tpose = arg_54_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["2020_tpose"]) then
				if arg_54_1.var_.characterEffect2020_tpose and not isNil(arg_54_1.actors_["2020_tpose"]) then
					arg_54_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["2020_tpose"]) and arg_54_1.var_.characterEffect2020_tpose then
				arg_54_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_57_2 = arg_54_1.actors_["3008ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect3008ui_story == nil then
				arg_54_1.var_.characterEffect3008ui_story = var_57_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_3 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.characterEffect3008ui_story and not isNil(var_57_2) then
					arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_54_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_3)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect3008ui_story then
				arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_54_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_57_4 = 0
			local var_57_5 = 0.7

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(101031013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 28 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 28)

				if (28 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 28)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031013", "story_v_out_101031.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_101031", "101031013", "story_v_out_101031.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_101031", "101031013", "story_v_out_101031.awb")

						arg_54_1:RecordAudio("101031013", var_57_11)
						arg_54_1:RecordAudio("101031013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_101031", "101031013", "story_v_out_101031.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_101031", "101031013", "story_v_out_101031.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play101031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 101031014
		arg_58_1.duration_ = 2.47

		local var_58_0 = {
			ja = 2.466,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play101031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["3008ui_story"]) and arg_58_1.var_.characterEffect3008ui_story == nil then
				arg_58_1.var_.characterEffect3008ui_story = arg_58_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["3008ui_story"]) then
				if arg_58_1.var_.characterEffect3008ui_story and not isNil(arg_58_1.actors_["3008ui_story"]) then
					arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["3008ui_story"]) and arg_58_1.var_.characterEffect3008ui_story then
				arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_61_2 = arg_58_1.actors_["2020_tpose"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect2020_tpose == nil then
				arg_58_1.var_.characterEffect2020_tpose = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.characterEffect2020_tpose and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_58_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_3)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect2020_tpose then
				arg_58_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_58_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_2")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_61_4 = 0
			local var_61_5 = 0.1

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_6 = arg_58_1:GetWordFromCfg(101031014)
				local var_61_7 = arg_58_1:FormatText(var_61_6.content)

				arg_58_1.text_.text = var_61_7

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 4 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 4)

				if (4 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 4)) > 0 and var_61_5 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_7
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031014", "story_v_out_101031.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_101031", "101031014", "story_v_out_101031.awb") / 1000

					if var_61_10 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_4
					end

					if var_61_6.prefab_name ~= "" and arg_58_1.actors_[var_61_6.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_6.prefab_name].transform, "story_v_out_101031", "101031014", "story_v_out_101031.awb")

						arg_58_1:RecordAudio("101031014", var_61_11)
						arg_58_1:RecordAudio("101031014", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_101031", "101031014", "story_v_out_101031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_101031", "101031014", "story_v_out_101031.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_12 and arg_58_1.time_ < var_61_4 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play101031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 101031015
		arg_62_1.duration_ = 9.7

		local var_62_0 = {
			ja = 9.7,
			ko = 7.6,
			zh = 7.233,
			en = 8.2
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play101031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["2020_tpose"]) and arg_62_1.var_.characterEffect2020_tpose == nil then
				arg_62_1.var_.characterEffect2020_tpose = arg_62_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["2020_tpose"]) then
				if arg_62_1.var_.characterEffect2020_tpose and not isNil(arg_62_1.actors_["2020_tpose"]) then
					arg_62_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["2020_tpose"]) and arg_62_1.var_.characterEffect2020_tpose then
				arg_62_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["3008ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_3 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_62_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_3)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect3008ui_story then
				arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_62_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_65_4 = 0
			local var_65_5 = 0.95

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(101031015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 38 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 38)

				if (38 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 38)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031015", "story_v_out_101031.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_101031", "101031015", "story_v_out_101031.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_out_101031", "101031015", "story_v_out_101031.awb")

						arg_62_1:RecordAudio("101031015", var_65_11)
						arg_62_1:RecordAudio("101031015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_101031", "101031015", "story_v_out_101031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_101031", "101031015", "story_v_out_101031.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_12 and arg_62_1.time_ < var_65_4 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play101031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 101031016
		arg_66_1.duration_ = 6.13

		local var_66_0 = {
			ja = 6.133,
			ko = 3.8,
			zh = 3.766,
			en = 4.666
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
			arg_66_1.auto_ = false
		end

		function arg_66_1.playNext_(arg_68_0)
			arg_66_1.onStoryFinished_()
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = arg_66_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) then
				if arg_66_1.var_.characterEffect3008ui_story and not isNil(arg_66_1.actors_["3008ui_story"]) then
					arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story then
				arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["2020_tpose"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect2020_tpose == nil then
				arg_66_1.var_.characterEffect2020_tpose = var_69_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_3 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.characterEffect2020_tpose and not isNil(var_69_2) then
					arg_66_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_66_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_3)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect2020_tpose then
				arg_66_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_66_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_69_4 = 0
			local var_69_5 = 0.475

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(101031016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 19 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 19)

				if (19 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 19)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101031", "101031016", "story_v_out_101031.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_101031", "101031016", "story_v_out_101031.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_101031", "101031016", "story_v_out_101031.awb")

						arg_66_1:RecordAudio("101031016", var_69_11)
						arg_66_1:RecordAudio("101031016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_101031", "101031016", "story_v_out_101031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_101031", "101031016", "story_v_out_101031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a"
	},
	voices = {
		"story_v_out_101031.awb"
	}
}
