return {
	Play421041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421041001
		arg_1_1.duration_ = 3.83

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D12a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D12a")
				var_4_0.name = "D12a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D12a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D12a

				arg_1_1.bgs_.D12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D12a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "1047ui_story"

			if arg_1_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1047ui_story"].transform

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1047ui_story = var_4_12.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_4_13 = 0.001

			if 1.83333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.83333333333333 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_1_1.time_ - 1.83333333333333) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.83333333333333 + var_4_13 and arg_1_1.time_ < 1.83333333333333 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.13, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1047ui_story"]

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1047ui_story == nil then
				arg_1_1.var_.characterEffect1047ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.83333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.83333333333333 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1047ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.83333333333333 + var_4_15 and arg_1_1.time_ < 1.83333333333333 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1047ui_story then
				arg_1_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(421041001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 6 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 6)

				if (6 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 6)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041001", "story_v_out_421041.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_421041", "421041001", "story_v_out_421041.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_421041", "421041001", "story_v_out_421041.awb")

						arg_1_1:RecordAudio("421041001", var_4_32)
						arg_1_1:RecordAudio("421041001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421041", "421041001", "story_v_out_421041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421041", "421041001", "story_v_out_421041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play421041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421041002
		arg_9_1.duration_ = 8.87

		local var_9_0 = {
			zh = 6.5,
			ja = 8.866
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10145ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10145ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10145ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10145ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10145ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10145ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.78, -1, -6.2)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1047ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1047ui_story = var_12_5.localPosition
			end

			local var_12_6 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_9_1.time_ - 0) / var_12_6)
				var_12_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_5.position).x, (manager.ui.mainCamera.transform.position - var_12_5.position).y, (manager.ui.mainCamera.transform.position - var_12_5.position).z)
				var_12_5.localEulerAngles.z = 0
				var_12_5.localEulerAngles.x = 0
				var_12_5.localEulerAngles = var_12_5.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_12_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_5.position).x, (manager.ui.mainCamera.transform.position - var_12_5.position).y, (manager.ui.mainCamera.transform.position - var_12_5.position).z)
				var_12_5.localEulerAngles.z = 0
				var_12_5.localEulerAngles.x = 0
				var_12_5.localEulerAngles = var_12_5.localEulerAngles
			end

			local var_12_7 = arg_9_1.actors_["10145ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect10145ui_story == nil then
				arg_9_1.var_.characterEffect10145ui_story = var_12_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_8 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 and not isNil(var_12_7) then
				if arg_9_1.var_.characterEffect10145ui_story and not isNil(var_12_7) then
					arg_9_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect10145ui_story then
				arg_9_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_12_10 = arg_9_1.actors_["1047ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1047ui_story == nil then
				arg_9_1.var_.characterEffect1047ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect1047ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1047ui_story then
				arg_9_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_12_12 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_12 + 1 and arg_9_1.time_ < var_12_12 + 1 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_13 = 0
			local var_12_14 = 0.6

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_15 = arg_9_1:GetWordFromCfg(421041002)
				local var_12_16 = arg_9_1:FormatText(var_12_15.content)

				arg_9_1.text_.text = var_12_16

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_18 = 24 <= 0 and var_12_14 or var_12_14 * (utf8.len(var_12_16) / 24)

				if (24 <= 0 and var_12_14 or var_12_14 * (utf8.len(var_12_16) / 24)) > 0 and var_12_14 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18

					if var_12_18 + var_12_13 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_13
					end
				end

				arg_9_1.text_.text = var_12_16
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041002", "story_v_out_421041.awb") ~= 0 then
					local var_12_19 = manager.audio:GetVoiceLength("story_v_out_421041", "421041002", "story_v_out_421041.awb") / 1000

					if var_12_19 + var_12_13 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_13
					end

					if var_12_15.prefab_name ~= "" and arg_9_1.actors_[var_12_15.prefab_name] ~= nil then
						local var_12_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_15.prefab_name].transform, "story_v_out_421041", "421041002", "story_v_out_421041.awb")

						arg_9_1:RecordAudio("421041002", var_12_20)
						arg_9_1:RecordAudio("421041002", var_12_20)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421041", "421041002", "story_v_out_421041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421041", "421041002", "story_v_out_421041.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_21 = math.max(var_12_14, arg_9_1.talkMaxDuration)

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_21 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_13) / var_12_21

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_13 + var_12_21 and arg_9_1.time_ < var_12_13 + var_12_21 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play421041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421041003
		arg_13_1.duration_ = 4.27

		local var_13_0 = {
			zh = 3.066,
			ja = 4.266
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play421041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10145ui_story = arg_13_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10145ui_story"].transform.position).z)
				arg_13_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10145ui_story"].transform.localEulerAngles = arg_13_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_13_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10145ui_story"].transform.position).z)
				arg_13_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10145ui_story"].transform.localEulerAngles = arg_13_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145actionlink/10145action434")
			end

			local var_16_1 = 0
			local var_16_2 = 0.325

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(421041003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 13 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 13)

				if (13 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 13)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041003", "story_v_out_421041.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_421041", "421041003", "story_v_out_421041.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_421041", "421041003", "story_v_out_421041.awb")

						arg_13_1:RecordAudio("421041003", var_16_8)
						arg_13_1:RecordAudio("421041003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421041", "421041003", "story_v_out_421041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421041", "421041003", "story_v_out_421041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play421041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play421041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1047ui_story = arg_17_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).z)
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles = arg_17_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1047ui_story"].transform.position).z)
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1047ui_story"].transform.localEulerAngles = arg_17_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10145ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10145ui_story = var_20_1.localPosition
			end

			local var_20_2 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 then
				var_20_1.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_2)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 then
				var_20_1.localPosition = Vector3.New(0, 100, 0)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			local var_20_3 = 0
			local var_20_4 = 0.75

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(421041004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 30 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 30)

				if (30 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 30)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play421041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421041005
		arg_21_1.duration_ = 2.97

		local var_21_0 = {
			zh = 2.5,
			ja = 2.966
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play421041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = arg_21_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).z)
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles = arg_21_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_21_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).z)
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles = arg_21_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1047ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_24_4 = 0
			local var_24_5 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(421041005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 12 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 12)

				if (12 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 12)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041005", "story_v_out_421041.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041005", "story_v_out_421041.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_421041", "421041005", "story_v_out_421041.awb")

						arg_21_1:RecordAudio("421041005", var_24_11)
						arg_21_1:RecordAudio("421041005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421041", "421041005", "story_v_out_421041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421041", "421041005", "story_v_out_421041.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play421041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421041006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = arg_25_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 0.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(421041006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)

				if (23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play421041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421041007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play421041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "10102ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10102ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["10102ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["10102ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["10102ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10102ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_5 = arg_29_1.actors_["10102ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10102ui_story == nil then
				arg_29_1.var_.characterEffect10102ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect10102ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10102ui_story then
				arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_32_8 = 0
			local var_32_9 = 0.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[401].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_10 = arg_29_1:GetWordFromCfg(421041007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 6 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 6)

				if (6 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 6)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041007", "story_v_out_421041.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041007", "story_v_out_421041.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_421041", "421041007", "story_v_out_421041.awb")

						arg_29_1:RecordAudio("421041007", var_32_15)
						arg_29_1:RecordAudio("421041007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421041", "421041007", "story_v_out_421041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421041", "421041007", "story_v_out_421041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play421041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421041008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play421041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10102ui_story = arg_33_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).z)
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles = arg_33_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).z)
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles = arg_33_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_36_1 = 0
			local var_36_2 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(421041008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 15 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 15)

				if (15 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 15)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play421041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421041009
		arg_37_1.duration_ = 15

		local var_37_0 = {
			zh = 13.766,
			ja = 15
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play421041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10145ui_story = arg_37_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10145ui_story"].transform.position).z)
				arg_37_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10145ui_story"].transform.localEulerAngles = arg_37_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_37_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10145ui_story"].transform.position).z)
				arg_37_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10145ui_story"].transform.localEulerAngles = arg_37_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10145ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10145ui_story == nil then
				arg_37_1.var_.characterEffect10145ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10145ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10145ui_story then
				arg_37_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 1.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(421041009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 56 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 56)

				if (56 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 56)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041009", "story_v_out_421041.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041009", "story_v_out_421041.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_421041", "421041009", "story_v_out_421041.awb")

						arg_37_1:RecordAudio("421041009", var_40_11)
						arg_37_1:RecordAudio("421041009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421041", "421041009", "story_v_out_421041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421041", "421041009", "story_v_out_421041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play421041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421041010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10145ui_story"]) and arg_41_1.var_.characterEffect10145ui_story == nil then
				arg_41_1.var_.characterEffect10145ui_story = arg_41_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10145ui_story"]) then
				if arg_41_1.var_.characterEffect10145ui_story and not isNil(arg_41_1.actors_["10145ui_story"]) then
					arg_41_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10145ui_story"]) and arg_41_1.var_.characterEffect10145ui_story then
				arg_41_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(421041010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 18 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 18)

				if (18 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 18)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play421041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421041011
		arg_45_1.duration_ = 9.6

		local var_45_0 = {
			zh = 6.6,
			ja = 9.6
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play421041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_48_0 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_45_1.stage_.transform)

				var_48_0.name = "10143ui_story"
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["10143ui_story"] = var_48_0

				local var_48_1 = var_48_0:GetComponentInChildren(typeof(CharacterEffect))

				var_48_1.enabled = true

				local var_48_2 = GameObjectTools.GetOrAddComponent(var_48_0, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_1.transform, false)

				arg_45_1.var_["10143ui_story" .. "Animator"] = var_48_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_["10143ui_story" .. "Animator"].applyRootMotion = true
				arg_45_1.var_["10143ui_story" .. "LipSync"] = var_48_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_3 = arg_45_1.actors_["10143ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10143ui_story = var_48_3.localPosition
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_3.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_45_1.time_ - 0) / var_48_4)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_3.localPosition = Vector3.New(0, -1.06, -6)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			local var_48_5 = arg_45_1.actors_["10145ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10145ui_story = var_48_5.localPosition
			end

			local var_48_6 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 then
				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_6)
				var_48_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_5.position).x, (manager.ui.mainCamera.transform.position - var_48_5.position).y, (manager.ui.mainCamera.transform.position - var_48_5.position).z)
				var_48_5.localEulerAngles.z = 0
				var_48_5.localEulerAngles.x = 0
				var_48_5.localEulerAngles = var_48_5.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(0, 100, 0)
				var_48_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_5.position).x, (manager.ui.mainCamera.transform.position - var_48_5.position).y, (manager.ui.mainCamera.transform.position - var_48_5.position).z)
				var_48_5.localEulerAngles.z = 0
				var_48_5.localEulerAngles.x = 0
				var_48_5.localEulerAngles = var_48_5.localEulerAngles
			end

			local var_48_7 = arg_45_1.actors_["10143ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.characterEffect10143ui_story == nil then
				arg_45_1.var_.characterEffect10143ui_story = var_48_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_8 and not isNil(var_48_7) then
				if arg_45_1.var_.characterEffect10143ui_story and not isNil(var_48_7) then
					arg_45_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_8 and arg_45_1.time_ < 0 + var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.characterEffect10143ui_story then
				arg_45_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_48_10 = 0
			local var_48_11 = 0.8

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_12 = arg_45_1:GetWordFromCfg(421041011)
				local var_48_13 = arg_45_1:FormatText(var_48_12.content)

				arg_45_1.text_.text = var_48_13

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 32 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 32)

				if (32 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 32)) > 0 and var_48_11 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_13
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041011", "story_v_out_421041.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_421041", "421041011", "story_v_out_421041.awb") / 1000

					if var_48_16 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_10
					end

					if var_48_12.prefab_name ~= "" and arg_45_1.actors_[var_48_12.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_12.prefab_name].transform, "story_v_out_421041", "421041011", "story_v_out_421041.awb")

						arg_45_1:RecordAudio("421041011", var_48_17)
						arg_45_1:RecordAudio("421041011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421041", "421041011", "story_v_out_421041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421041", "421041011", "story_v_out_421041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_18 and arg_45_1.time_ < var_48_10 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play421041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421041012
		arg_49_1.duration_ = 12

		local var_49_0 = {
			zh = 12,
			ja = 9.966
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play421041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10145ui_story = arg_49_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).z)
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles = arg_49_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_49_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).z)
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles = arg_49_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10145ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10145ui_story == nil then
				arg_49_1.var_.characterEffect10145ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10145ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10145ui_story then
				arg_49_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_4 = arg_49_1.actors_["10143ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10143ui_story = var_52_4.localPosition
			end

			local var_52_5 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 then
				var_52_4.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_5)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				var_52_4.localPosition = Vector3.New(0, 100, 0)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			local var_52_6 = 0
			local var_52_7 = 1.025

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(421041012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 41 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 41)

				if (41 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 41)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041012", "story_v_out_421041.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041012", "story_v_out_421041.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_421041", "421041012", "story_v_out_421041.awb")

						arg_49_1:RecordAudio("421041012", var_52_13)
						arg_49_1:RecordAudio("421041012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421041", "421041012", "story_v_out_421041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421041", "421041012", "story_v_out_421041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play421041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421041013
		arg_53_1.duration_ = 15.33

		local var_53_0 = {
			zh = 10.433,
			ja = 15.333
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play421041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1047ui_story = arg_53_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1047ui_story"].transform.position).z)
				arg_53_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1047ui_story"].transform.localEulerAngles = arg_53_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_53_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1047ui_story"].transform.position).z)
				arg_53_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1047ui_story"].transform.localEulerAngles = arg_53_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10145ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10145ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_53_1.time_ - 0) / var_56_2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				var_56_1.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			local var_56_3 = arg_53_1.actors_["1047ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect1047ui_story == nil then
				arg_53_1.var_.characterEffect1047ui_story = var_56_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_4 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 and not isNil(var_56_3) then
				if arg_53_1.var_.characterEffect1047ui_story and not isNil(var_56_3) then
					arg_53_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect1047ui_story then
				arg_53_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_56_6 = arg_53_1.actors_["10145ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect10145ui_story == nil then
				arg_53_1.var_.characterEffect10145ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 and not isNil(var_56_6) then
				if arg_53_1.var_.characterEffect10145ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_7)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect10145ui_story then
				arg_53_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_56_8 = 0
			local var_56_9 = 1.2

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(421041013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 48 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 48)

				if (48 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 48)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041013", "story_v_out_421041.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041013", "story_v_out_421041.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_421041", "421041013", "story_v_out_421041.awb")

						arg_53_1:RecordAudio("421041013", var_56_15)
						arg_53_1:RecordAudio("421041013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_421041", "421041013", "story_v_out_421041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_421041", "421041013", "story_v_out_421041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play421041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 421041014
		arg_57_1.duration_ = 9.13

		local var_57_0 = {
			zh = 6.5,
			ja = 9.133
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play421041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10143ui_story = arg_57_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10143ui_story"].transform.position).z)
				arg_57_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10143ui_story"].transform.localEulerAngles = arg_57_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_57_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10143ui_story"].transform.position).z)
				arg_57_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10143ui_story"].transform.localEulerAngles = arg_57_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1047ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1047ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = arg_57_1.actors_["10143ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10143ui_story == nil then
				arg_57_1.var_.characterEffect10143ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect10143ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10143ui_story then
				arg_57_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_60_6 = arg_57_1.actors_["1047ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1047ui_story == nil then
				arg_57_1.var_.characterEffect1047ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 and not isNil(var_60_6) then
				if arg_57_1.var_.characterEffect1047ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_7)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1047ui_story then
				arg_57_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_8 = 0
			local var_60_9 = 0.725

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(421041014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 28 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 28)

				if (28 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 28)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041014", "story_v_out_421041.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041014", "story_v_out_421041.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_421041", "421041014", "story_v_out_421041.awb")

						arg_57_1:RecordAudio("421041014", var_60_15)
						arg_57_1:RecordAudio("421041014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_421041", "421041014", "story_v_out_421041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_421041", "421041014", "story_v_out_421041.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play421041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 421041015
		arg_61_1.duration_ = 4.23

		local var_61_0 = {
			zh = 2.3,
			ja = 4.233
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play421041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10145ui_story = arg_61_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10145ui_story"].transform.position).z)
				arg_61_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10145ui_story"].transform.localEulerAngles = arg_61_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_61_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10145ui_story"].transform.position).z)
				arg_61_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10145ui_story"].transform.localEulerAngles = arg_61_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10145ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10145ui_story == nil then
				arg_61_1.var_.characterEffect10145ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10145ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10145ui_story then
				arg_61_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["10143ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10143ui_story == nil then
				arg_61_1.var_.characterEffect10143ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 and not isNil(var_64_4) then
				if arg_61_1.var_.characterEffect10143ui_story and not isNil(var_64_4) then
					arg_61_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_5)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10143ui_story then
				arg_61_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(421041015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 10 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 10)

				if (10 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 10)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041015", "story_v_out_421041.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041015", "story_v_out_421041.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_421041", "421041015", "story_v_out_421041.awb")

						arg_61_1:RecordAudio("421041015", var_64_13)
						arg_61_1:RecordAudio("421041015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_421041", "421041015", "story_v_out_421041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_421041", "421041015", "story_v_out_421041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play421041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 421041016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play421041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10145ui_story = arg_65_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).z)
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles = arg_65_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).z)
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles = arg_65_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10143ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10143ui_story = var_68_1.localPosition
			end

			local var_68_2 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 then
				var_68_1.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_2)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 then
				var_68_1.localPosition = Vector3.New(0, 100, 0)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			if 0.6 < arg_65_1.time_ and arg_65_1.time_ <= 0.6 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_140", "se_story_140_electric01", "")
			end

			local var_68_4 = 0
			local var_68_5 = 1.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(421041016).content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 64 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 64)

				if (64 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 64)) > 0 and var_68_5 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_9 and arg_65_1.time_ < var_68_4 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play421041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 421041017
		arg_69_1.duration_ = 6.03

		local var_69_0 = {
			zh = 5,
			ja = 6.033
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play421041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10143ui_story = arg_69_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10143ui_story"].transform.position).z)
				arg_69_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10143ui_story"].transform.localEulerAngles = arg_69_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_69_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10143ui_story"].transform.position).z)
				arg_69_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10143ui_story"].transform.localEulerAngles = arg_69_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10143ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10143ui_story == nil then
				arg_69_1.var_.characterEffect10143ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10143ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10143ui_story then
				arg_69_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_72_4 = 0
			local var_72_5 = 0.6

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(421041017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 24 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 24)

				if (24 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 24)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041017", "story_v_out_421041.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041017", "story_v_out_421041.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_421041", "421041017", "story_v_out_421041.awb")

						arg_69_1:RecordAudio("421041017", var_72_11)
						arg_69_1:RecordAudio("421041017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_421041", "421041017", "story_v_out_421041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_421041", "421041017", "story_v_out_421041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play421041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 421041018
		arg_73_1.duration_ = 4.2

		local var_73_0 = {
			zh = 2.166,
			ja = 4.2
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play421041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10102ui_story = arg_73_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).z)
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles = arg_73_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_73_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).z)
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles = arg_73_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10102ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10102ui_story == nil then
				arg_73_1.var_.characterEffect10102ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect10102ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10102ui_story then
				arg_73_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_76_4 = arg_73_1.actors_["10143ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10143ui_story == nil then
				arg_73_1.var_.characterEffect10143ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect10143ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10143ui_story then
				arg_73_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_76_6 = 0
			local var_76_7 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(421041018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 8 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 8)

				if (8 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 8)) > 0 and var_76_7 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041018", "story_v_out_421041.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041018", "story_v_out_421041.awb") / 1000

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_out_421041", "421041018", "story_v_out_421041.awb")

						arg_73_1:RecordAudio("421041018", var_76_13)
						arg_73_1:RecordAudio("421041018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_421041", "421041018", "story_v_out_421041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_421041", "421041018", "story_v_out_421041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play421041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 421041019
		arg_77_1.duration_ = 9.03

		local var_77_0 = {
			zh = 5.733,
			ja = 9.033
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play421041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10143ui_story = arg_77_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10143ui_story"].transform.position).z)
				arg_77_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10143ui_story"].transform.localEulerAngles = arg_77_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_77_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10143ui_story"].transform.position).z)
				arg_77_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10143ui_story"].transform.localEulerAngles = arg_77_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10143ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10143ui_story == nil then
				arg_77_1.var_.characterEffect10143ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect10143ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10143ui_story then
				arg_77_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.actors_["10102ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect10102ui_story == nil then
				arg_77_1.var_.characterEffect10102ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_5 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 and not isNil(var_80_4) then
				if arg_77_1.var_.characterEffect10102ui_story and not isNil(var_80_4) then
					arg_77_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_5)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect10102ui_story then
				arg_77_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_6 = 0
			local var_80_7 = 0.775

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(421041019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 31 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 31)

				if (31 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 31)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041019", "story_v_out_421041.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041019", "story_v_out_421041.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_421041", "421041019", "story_v_out_421041.awb")

						arg_77_1:RecordAudio("421041019", var_80_13)
						arg_77_1:RecordAudio("421041019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_421041", "421041019", "story_v_out_421041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_421041", "421041019", "story_v_out_421041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play421041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 421041020
		arg_81_1.duration_ = 4.27

		local var_81_0 = {
			zh = 3.666,
			ja = 4.266
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play421041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10102ui_story = arg_81_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10102ui_story"].transform.position).z)
				arg_81_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10102ui_story"].transform.localEulerAngles = arg_81_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_81_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10102ui_story"].transform.position).z)
				arg_81_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10102ui_story"].transform.localEulerAngles = arg_81_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["10102ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10102ui_story == nil then
				arg_81_1.var_.characterEffect10102ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect10102ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10102ui_story then
				arg_81_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["10143ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10143ui_story == nil then
				arg_81_1.var_.characterEffect10143ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_5 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 and not isNil(var_84_4) then
				if arg_81_1.var_.characterEffect10143ui_story and not isNil(var_84_4) then
					arg_81_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_5)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10143ui_story then
				arg_81_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_6 = 0
			local var_84_7 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(421041020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 15 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 15)

				if (15 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 15)) > 0 and var_84_7 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041020", "story_v_out_421041.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041020", "story_v_out_421041.awb") / 1000

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_421041", "421041020", "story_v_out_421041.awb")

						arg_81_1:RecordAudio("421041020", var_84_13)
						arg_81_1:RecordAudio("421041020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_421041", "421041020", "story_v_out_421041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_421041", "421041020", "story_v_out_421041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play421041021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 421041021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play421041022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10102ui_story"]) and arg_85_1.var_.characterEffect10102ui_story == nil then
				arg_85_1.var_.characterEffect10102ui_story = arg_85_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10102ui_story"]) then
				if arg_85_1.var_.characterEffect10102ui_story and not isNil(arg_85_1.actors_["10102ui_story"]) then
					arg_85_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10102ui_story"]) and arg_85_1.var_.characterEffect10102ui_story then
				arg_85_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.525

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(421041021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 21 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 21)

				if (21 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 21)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play421041022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 421041022
		arg_89_1.duration_ = 3.27

		local var_89_0 = {
			zh = 2.933,
			ja = 3.266
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play421041023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10102ui_story = arg_89_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10102ui_story"].transform.position).z)
				arg_89_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10102ui_story"].transform.localEulerAngles = arg_89_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_89_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10102ui_story"].transform.position).z)
				arg_89_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10102ui_story"].transform.localEulerAngles = arg_89_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["10102ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10102ui_story == nil then
				arg_89_1.var_.characterEffect10102ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect10102ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10102ui_story then
				arg_89_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.225

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(421041022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 9 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 9)

				if (9 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 9)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041022", "story_v_out_421041.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041022", "story_v_out_421041.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_421041", "421041022", "story_v_out_421041.awb")

						arg_89_1:RecordAudio("421041022", var_92_11)
						arg_89_1:RecordAudio("421041022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_421041", "421041022", "story_v_out_421041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_421041", "421041022", "story_v_out_421041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play421041023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 421041023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play421041024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10143ui_story = arg_93_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10143ui_story"].transform.position).z)
				arg_93_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10143ui_story"].transform.localEulerAngles = arg_93_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10143ui_story"].transform.position).z)
				arg_93_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10143ui_story"].transform.localEulerAngles = arg_93_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10102ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10102ui_story = var_96_1.localPosition
			end

			local var_96_2 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 then
				var_96_1.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_2)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 then
				var_96_1.localPosition = Vector3.New(0, 100, 0)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			local var_96_3 = 0
			local var_96_4 = 1.275

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_5 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(421041023).content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 51 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 51)

				if (51 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 51)) > 0 and var_96_4 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_8 and arg_93_1.time_ < var_96_3 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play421041024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421041024
		arg_97_1.duration_ = 11.57

		local var_97_0 = {
			zh = 11.1,
			ja = 11.566
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play421041025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10145ui_story = arg_97_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).z)
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles = arg_97_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_97_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).z)
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles = arg_97_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10145ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10145ui_story == nil then
				arg_97_1.var_.characterEffect10145ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10145ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10145ui_story then
				arg_97_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_100_4 = 0
			local var_100_5 = 1.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(421041024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 45 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 45)

				if (45 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 45)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041024", "story_v_out_421041.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041024", "story_v_out_421041.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_421041", "421041024", "story_v_out_421041.awb")

						arg_97_1:RecordAudio("421041024", var_100_11)
						arg_97_1:RecordAudio("421041024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_421041", "421041024", "story_v_out_421041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_421041", "421041024", "story_v_out_421041.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play421041025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421041025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play421041026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10145ui_story"]) and arg_101_1.var_.characterEffect10145ui_story == nil then
				arg_101_1.var_.characterEffect10145ui_story = arg_101_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10145ui_story"]) then
				if arg_101_1.var_.characterEffect10145ui_story and not isNil(arg_101_1.actors_["10145ui_story"]) then
					arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10145ui_story"]) and arg_101_1.var_.characterEffect10145ui_story then
				arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 1.35

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(421041025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 54 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 54)

				if (54 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 54)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play421041026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421041026
		arg_105_1.duration_ = 2.67

		local var_105_0 = {
			zh = 2.666,
			ja = 1.999999999999
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play421041027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10102ui_story = arg_105_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).z)
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles = arg_105_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_105_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).z)
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles = arg_105_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10145ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10145ui_story = var_108_1.localPosition
			end

			local var_108_2 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 then
				var_108_1.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_105_1.time_ - 0) / var_108_2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			local var_108_3 = arg_105_1.actors_["10102ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect10102ui_story == nil then
				arg_105_1.var_.characterEffect10102ui_story = var_108_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 and not isNil(var_108_3) then
				if arg_105_1.var_.characterEffect10102ui_story and not isNil(var_108_3) then
					arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect10102ui_story then
				arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_6 = 0
			local var_108_7 = 0.175

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(421041026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 7 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 7)

				if (7 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 7)) > 0 and var_108_7 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041026", "story_v_out_421041.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041026", "story_v_out_421041.awb") / 1000

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_421041", "421041026", "story_v_out_421041.awb")

						arg_105_1:RecordAudio("421041026", var_108_13)
						arg_105_1:RecordAudio("421041026", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_421041", "421041026", "story_v_out_421041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_421041", "421041026", "story_v_out_421041.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play421041027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421041027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play421041028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10102ui_story"]) and arg_109_1.var_.characterEffect10102ui_story == nil then
				arg_109_1.var_.characterEffect10102ui_story = arg_109_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10102ui_story"]) then
				if arg_109_1.var_.characterEffect10102ui_story and not isNil(arg_109_1.actors_["10102ui_story"]) then
					arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10102ui_story"]) and arg_109_1.var_.characterEffect10102ui_story then
				arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.5

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(421041027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 20 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 20)

				if (20 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 20)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play421041028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 421041028
		arg_113_1.duration_ = 19.6

		local var_113_0 = {
			zh = 13.6,
			ja = 19.6
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play421041029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10145ui_story = arg_113_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).z)
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles = arg_113_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_113_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).z)
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles = arg_113_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10102ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10102ui_story = var_116_1.localPosition
			end

			local var_116_2 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 then
				var_116_1.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_2)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 then
				var_116_1.localPosition = Vector3.New(0, 100, 0)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			local var_116_3 = arg_113_1.actors_["10145ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect10145ui_story == nil then
				arg_113_1.var_.characterEffect10145ui_story = var_116_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_4 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 and not isNil(var_116_3) then
				if arg_113_1.var_.characterEffect10145ui_story and not isNil(var_116_3) then
					arg_113_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect10145ui_story then
				arg_113_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_116_6 = 0
			local var_116_7 = 1.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(421041028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 62 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 62)

				if (62 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 62)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041028", "story_v_out_421041.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041028", "story_v_out_421041.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_421041", "421041028", "story_v_out_421041.awb")

						arg_113_1:RecordAudio("421041028", var_116_13)
						arg_113_1:RecordAudio("421041028", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_421041", "421041028", "story_v_out_421041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_421041", "421041028", "story_v_out_421041.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play421041029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 421041029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play421041030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10145ui_story"]) and arg_117_1.var_.characterEffect10145ui_story == nil then
				arg_117_1.var_.characterEffect10145ui_story = arg_117_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10145ui_story"]) then
				if arg_117_1.var_.characterEffect10145ui_story and not isNil(arg_117_1.actors_["10145ui_story"]) then
					arg_117_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10145ui_story"]) and arg_117_1.var_.characterEffect10145ui_story then
				arg_117_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.35

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(421041029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 14 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 14)

				if (14 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 14)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play421041030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 421041030
		arg_121_1.duration_ = 21.3

		local var_121_0 = {
			zh = 17.8,
			ja = 21.3
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play421041031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10145ui_story = arg_121_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10145ui_story"].transform.position).z)
				arg_121_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10145ui_story"].transform.localEulerAngles = arg_121_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_121_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10145ui_story"].transform.position).z)
				arg_121_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10145ui_story"].transform.localEulerAngles = arg_121_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10145ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10145ui_story == nil then
				arg_121_1.var_.characterEffect10145ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10145ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10145ui_story then
				arg_121_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_124_4 = 0
			local var_124_5 = 1.7

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(421041030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 68 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 68)

				if (68 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 68)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041030", "story_v_out_421041.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041030", "story_v_out_421041.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_421041", "421041030", "story_v_out_421041.awb")

						arg_121_1:RecordAudio("421041030", var_124_11)
						arg_121_1:RecordAudio("421041030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_421041", "421041030", "story_v_out_421041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_421041", "421041030", "story_v_out_421041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play421041031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 421041031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play421041032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10145ui_story"]) and arg_125_1.var_.characterEffect10145ui_story == nil then
				arg_125_1.var_.characterEffect10145ui_story = arg_125_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10145ui_story"]) then
				if arg_125_1.var_.characterEffect10145ui_story and not isNil(arg_125_1.actors_["10145ui_story"]) then
					arg_125_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10145ui_story"]) and arg_125_1.var_.characterEffect10145ui_story then
				arg_125_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.375

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(421041031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 15 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 15)

				if (15 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 15)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play421041032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 421041032
		arg_129_1.duration_ = 3.3

		local var_129_0 = {
			zh = 2.233,
			ja = 3.3
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play421041033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10145ui_story = arg_129_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).z)
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles = arg_129_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_129_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).z)
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles = arg_129_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["10145ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10145ui_story == nil then
				arg_129_1.var_.characterEffect10145ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect10145ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10145ui_story then
				arg_129_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_132_4 = 0
			local var_132_5 = 0.125

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(421041032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 5 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 5)

				if (5 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 5)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041032", "story_v_out_421041.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041032", "story_v_out_421041.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_421041", "421041032", "story_v_out_421041.awb")

						arg_129_1:RecordAudio("421041032", var_132_11)
						arg_129_1:RecordAudio("421041032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_421041", "421041032", "story_v_out_421041.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_421041", "421041032", "story_v_out_421041.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play421041033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 421041033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play421041034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10145ui_story"]) and arg_133_1.var_.characterEffect10145ui_story == nil then
				arg_133_1.var_.characterEffect10145ui_story = arg_133_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10145ui_story"]) then
				if arg_133_1.var_.characterEffect10145ui_story and not isNil(arg_133_1.actors_["10145ui_story"]) then
					arg_133_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10145ui_story"]) and arg_133_1.var_.characterEffect10145ui_story then
				arg_133_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.725

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(421041033).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 29 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 29)

				if (29 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 29)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play421041034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 421041034
		arg_137_1.duration_ = 11.07

		local var_137_0 = {
			zh = 11.066,
			ja = 8.3
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play421041035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10145ui_story = arg_137_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).z)
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles = arg_137_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_137_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).z)
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles = arg_137_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10145ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10145ui_story == nil then
				arg_137_1.var_.characterEffect10145ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10145ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10145ui_story then
				arg_137_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_140_4 = 0
			local var_140_5 = 0.825

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(421041034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 33 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 33)

				if (33 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 33)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041034", "story_v_out_421041.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041034", "story_v_out_421041.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_421041", "421041034", "story_v_out_421041.awb")

						arg_137_1:RecordAudio("421041034", var_140_11)
						arg_137_1:RecordAudio("421041034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_421041", "421041034", "story_v_out_421041.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_421041", "421041034", "story_v_out_421041.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play421041035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 421041035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play421041036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10145ui_story"]) and arg_141_1.var_.characterEffect10145ui_story == nil then
				arg_141_1.var_.characterEffect10145ui_story = arg_141_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10145ui_story"]) then
				if arg_141_1.var_.characterEffect10145ui_story and not isNil(arg_141_1.actors_["10145ui_story"]) then
					arg_141_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10145ui_story"]) and arg_141_1.var_.characterEffect10145ui_story then
				arg_141_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.075

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(421041035).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 3 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 3)

				if (3 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 3)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play421041036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 421041036
		arg_145_1.duration_ = 6.37

		local var_145_0 = {
			zh = 6.366,
			ja = 6.233
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play421041037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10145ui_story = arg_145_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).z)
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles = arg_145_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_145_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).z)
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles = arg_145_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10145ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10145ui_story == nil then
				arg_145_1.var_.characterEffect10145ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10145ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10145ui_story then
				arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_148_4 = 0
			local var_148_5 = 0.65

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(421041036)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 26 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 26)

				if (26 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 26)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041036", "story_v_out_421041.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041036", "story_v_out_421041.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_421041", "421041036", "story_v_out_421041.awb")

						arg_145_1:RecordAudio("421041036", var_148_11)
						arg_145_1:RecordAudio("421041036", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_421041", "421041036", "story_v_out_421041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_421041", "421041036", "story_v_out_421041.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play421041037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 421041037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play421041038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10145ui_story"]) and arg_149_1.var_.characterEffect10145ui_story == nil then
				arg_149_1.var_.characterEffect10145ui_story = arg_149_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10145ui_story"]) then
				if arg_149_1.var_.characterEffect10145ui_story and not isNil(arg_149_1.actors_["10145ui_story"]) then
					arg_149_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10145ui_story"]) and arg_149_1.var_.characterEffect10145ui_story then
				arg_149_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 0.05

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(421041037).content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 2 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 2)

				if (2 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 2)) > 0 and var_152_2 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_6 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_6 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_6

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_6 and arg_149_1.time_ < var_152_1 + var_152_6 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play421041038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 421041038
		arg_153_1.duration_ = 7.03

		local var_153_0 = {
			zh = 5,
			ja = 7.033
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play421041039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10143ui_story = arg_153_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10143ui_story"].transform.position).z)
				arg_153_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10143ui_story"].transform.localEulerAngles = arg_153_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_153_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10143ui_story"].transform.position).z)
				arg_153_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10143ui_story"].transform.localEulerAngles = arg_153_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["10145ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10145ui_story = var_156_1.localPosition
			end

			local var_156_2 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 then
				var_156_1.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_153_1.time_ - 0) / var_156_2)
				var_156_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_1.position).x, (manager.ui.mainCamera.transform.position - var_156_1.position).y, (manager.ui.mainCamera.transform.position - var_156_1.position).z)
				var_156_1.localEulerAngles.z = 0
				var_156_1.localEulerAngles.x = 0
				var_156_1.localEulerAngles = var_156_1.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 then
				var_156_1.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_156_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_1.position).x, (manager.ui.mainCamera.transform.position - var_156_1.position).y, (manager.ui.mainCamera.transform.position - var_156_1.position).z)
				var_156_1.localEulerAngles.z = 0
				var_156_1.localEulerAngles.x = 0
				var_156_1.localEulerAngles = var_156_1.localEulerAngles
			end

			local var_156_3 = arg_153_1.actors_["10143ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_3) and arg_153_1.var_.characterEffect10143ui_story == nil then
				arg_153_1.var_.characterEffect10143ui_story = var_156_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_4 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 and not isNil(var_156_3) then
				if arg_153_1.var_.characterEffect10143ui_story and not isNil(var_156_3) then
					arg_153_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 and not isNil(var_156_3) and arg_153_1.var_.characterEffect10143ui_story then
				arg_153_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_156_6 = 0
			local var_156_7 = 0.675

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(421041038)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 27 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 27)

				if (27 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 27)) > 0 and var_156_7 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041038", "story_v_out_421041.awb") ~= 0 then
					local var_156_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041038", "story_v_out_421041.awb") / 1000

					if var_156_12 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_6
					end

					if var_156_8.prefab_name ~= "" and arg_153_1.actors_[var_156_8.prefab_name] ~= nil then
						local var_156_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_8.prefab_name].transform, "story_v_out_421041", "421041038", "story_v_out_421041.awb")

						arg_153_1:RecordAudio("421041038", var_156_13)
						arg_153_1:RecordAudio("421041038", var_156_13)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_421041", "421041038", "story_v_out_421041.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_421041", "421041038", "story_v_out_421041.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play421041039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 421041039
		arg_157_1.duration_ = 9.13

		local var_157_0 = {
			zh = 6.966,
			ja = 9.133
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play421041040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10145ui_story = arg_157_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10145ui_story"].transform.position).z)
				arg_157_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10145ui_story"].transform.localEulerAngles = arg_157_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_157_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10145ui_story"].transform.position).z)
				arg_157_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10145ui_story"].transform.localEulerAngles = arg_157_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["10145ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10145ui_story == nil then
				arg_157_1.var_.characterEffect10145ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect10145ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10145ui_story then
				arg_157_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["10143ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect10143ui_story == nil then
				arg_157_1.var_.characterEffect10143ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect10143ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect10143ui_story then
				arg_157_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_160_6 = 0
			local var_160_7 = 0.775

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(421041039)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 31 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 31)

				if (31 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 31)) > 0 and var_160_7 < var_160_11 then
					arg_157_1.talkMaxDuration = var_160_11

					if var_160_11 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041039", "story_v_out_421041.awb") ~= 0 then
					local var_160_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041039", "story_v_out_421041.awb") / 1000

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end

					if var_160_8.prefab_name ~= "" and arg_157_1.actors_[var_160_8.prefab_name] ~= nil then
						local var_160_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_8.prefab_name].transform, "story_v_out_421041", "421041039", "story_v_out_421041.awb")

						arg_157_1:RecordAudio("421041039", var_160_13)
						arg_157_1:RecordAudio("421041039", var_160_13)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_421041", "421041039", "story_v_out_421041.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_421041", "421041039", "story_v_out_421041.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play421041040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 421041040
		arg_161_1.duration_ = 13.4

		local var_161_0 = {
			zh = 10.066,
			ja = 13.4
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play421041041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1047ui_story = arg_161_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).z)
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles = arg_161_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_161_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).z)
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles = arg_161_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["10145ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10145ui_story = var_164_1.localPosition
			end

			local var_164_2 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 then
				var_164_1.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_2)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 then
				var_164_1.localPosition = Vector3.New(0, 100, 0)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			local var_164_3 = arg_161_1.actors_["1047ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect1047ui_story == nil then
				arg_161_1.var_.characterEffect1047ui_story = var_164_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_4 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 and not isNil(var_164_3) then
				if arg_161_1.var_.characterEffect1047ui_story and not isNil(var_164_3) then
					arg_161_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect1047ui_story then
				arg_161_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_164_6 = arg_161_1.actors_["10145ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10145ui_story == nil then
				arg_161_1.var_.characterEffect10145ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 and not isNil(var_164_6) then
				if arg_161_1.var_.characterEffect10145ui_story and not isNil(var_164_6) then
					arg_161_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_7)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10145ui_story then
				arg_161_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_164_8 = 0
			local var_164_9 = 1.125

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(421041040)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 45 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 45)

				if (45 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 45)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041040", "story_v_out_421041.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041040", "story_v_out_421041.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_421041", "421041040", "story_v_out_421041.awb")

						arg_161_1:RecordAudio("421041040", var_164_15)
						arg_161_1:RecordAudio("421041040", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_421041", "421041040", "story_v_out_421041.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_421041", "421041040", "story_v_out_421041.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play421041041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421041041
		arg_165_1.duration_ = 12

		local var_165_0 = {
			zh = 8.733,
			ja = 12
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play421041042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10143ui_story = arg_165_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10143ui_story"].transform.position).z)
				arg_165_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10143ui_story"].transform.localEulerAngles = arg_165_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_165_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10143ui_story"].transform.position).z)
				arg_165_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10143ui_story"].transform.localEulerAngles = arg_165_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["10143ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10143ui_story == nil then
				arg_165_1.var_.characterEffect10143ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect10143ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10143ui_story then
				arg_165_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["1047ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1047ui_story == nil then
				arg_165_1.var_.characterEffect1047ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect1047ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1047ui_story then
				arg_165_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_168_6 = 0
			local var_168_7 = 0.9

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(421041041)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 36 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 36)

				if (36 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 36)) > 0 and var_168_7 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041041", "story_v_out_421041.awb") ~= 0 then
					local var_168_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041041", "story_v_out_421041.awb") / 1000

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_421041", "421041041", "story_v_out_421041.awb")

						arg_165_1:RecordAudio("421041041", var_168_13)
						arg_165_1:RecordAudio("421041041", var_168_13)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_421041", "421041041", "story_v_out_421041.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_421041", "421041041", "story_v_out_421041.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play421041042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421041042
		arg_169_1.duration_ = 10.13

		local var_169_0 = {
			zh = 5.933,
			ja = 10.133
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play421041043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1047ui_story = arg_169_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1047ui_story"].transform.position).z)
				arg_169_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1047ui_story"].transform.localEulerAngles = arg_169_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_169_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1047ui_story"].transform.position).z)
				arg_169_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1047ui_story"].transform.localEulerAngles = arg_169_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1047ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1047ui_story == nil then
				arg_169_1.var_.characterEffect1047ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1047ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1047ui_story then
				arg_169_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_172_4 = arg_169_1.actors_["10143ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect10143ui_story == nil then
				arg_169_1.var_.characterEffect10143ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_5 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 and not isNil(var_172_4) then
				if arg_169_1.var_.characterEffect10143ui_story and not isNil(var_172_4) then
					arg_169_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_5)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect10143ui_story then
				arg_169_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_172_6 = 0
			local var_172_7 = 0.6

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(421041042)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 24 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 24)

				if (24 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 24)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041042", "story_v_out_421041.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041042", "story_v_out_421041.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_421041", "421041042", "story_v_out_421041.awb")

						arg_169_1:RecordAudio("421041042", var_172_13)
						arg_169_1:RecordAudio("421041042", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_421041", "421041042", "story_v_out_421041.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_421041", "421041042", "story_v_out_421041.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play421041043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421041043
		arg_173_1.duration_ = 2.37

		local var_173_0 = {
			zh = 2.366,
			ja = 2.233
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play421041044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10102ui_story = arg_173_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).z)
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles = arg_173_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_173_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).z)
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles = arg_173_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["10143ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10143ui_story = var_176_1.localPosition
			end

			local var_176_2 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 then
				var_176_1.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_2)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 then
				var_176_1.localPosition = Vector3.New(0, 100, 0)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			local var_176_3 = arg_173_1.actors_["10102ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect10102ui_story == nil then
				arg_173_1.var_.characterEffect10102ui_story = var_176_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_4 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 and not isNil(var_176_3) then
				if arg_173_1.var_.characterEffect10102ui_story and not isNil(var_176_3) then
					arg_173_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect10102ui_story then
				arg_173_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_176_6 = arg_173_1.actors_["1047ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1047ui_story == nil then
				arg_173_1.var_.characterEffect1047ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect1047ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1047ui_story then
				arg_173_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_8 = 0
			local var_176_9 = 0.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(421041043)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 9 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 9)

				if (9 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 9)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041043", "story_v_out_421041.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041043", "story_v_out_421041.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_421041", "421041043", "story_v_out_421041.awb")

						arg_173_1:RecordAudio("421041043", var_176_15)
						arg_173_1:RecordAudio("421041043", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421041", "421041043", "story_v_out_421041.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421041", "421041043", "story_v_out_421041.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play421041044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421041044
		arg_177_1.duration_ = 16.27

		local var_177_0 = {
			zh = 9.533,
			ja = 16.266
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play421041045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047ui_story = arg_177_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1047ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1047ui_story == nil then
				arg_177_1.var_.characterEffect1047ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1047ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1047ui_story then
				arg_177_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["10102ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect10102ui_story == nil then
				arg_177_1.var_.characterEffect10102ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_5 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 and not isNil(var_180_4) then
				if arg_177_1.var_.characterEffect10102ui_story and not isNil(var_180_4) then
					arg_177_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_5)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect10102ui_story then
				arg_177_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_180_6 = 0
			local var_180_7 = 1.175

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(421041044)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 48 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 48)

				if (48 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 48)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041044", "story_v_out_421041.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041044", "story_v_out_421041.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_421041", "421041044", "story_v_out_421041.awb")

						arg_177_1:RecordAudio("421041044", var_180_13)
						arg_177_1:RecordAudio("421041044", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_421041", "421041044", "story_v_out_421041.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_421041", "421041044", "story_v_out_421041.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play421041045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421041045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play421041046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1047ui_story"]) and arg_181_1.var_.characterEffect1047ui_story == nil then
				arg_181_1.var_.characterEffect1047ui_story = arg_181_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1047ui_story"]) then
				if arg_181_1.var_.characterEffect1047ui_story and not isNil(arg_181_1.actors_["1047ui_story"]) then
					arg_181_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1047ui_story"]) and arg_181_1.var_.characterEffect1047ui_story then
				arg_181_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.4

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(421041045).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 16 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 16)

				if (16 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 16)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play421041046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421041046
		arg_185_1.duration_ = 11.3

		local var_185_0 = {
			zh = 10.7,
			ja = 11.3
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play421041047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1047ui_story = arg_185_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["10102ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10102ui_story = var_188_1.localPosition
			end

			local var_188_2 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 then
				var_188_1.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_2)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 then
				var_188_1.localPosition = Vector3.New(0, 100, 0)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			local var_188_3 = arg_185_1.actors_["10145ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10145ui_story = var_188_3.localPosition
			end

			local var_188_4 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				var_188_3.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_185_1.time_ - 0) / var_188_4)
				var_188_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_3.position).x, (manager.ui.mainCamera.transform.position - var_188_3.position).y, (manager.ui.mainCamera.transform.position - var_188_3.position).z)
				var_188_3.localEulerAngles.z = 0
				var_188_3.localEulerAngles.x = 0
				var_188_3.localEulerAngles = var_188_3.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				var_188_3.localPosition = Vector3.New(0, -1, -6.2)
				var_188_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_3.position).x, (manager.ui.mainCamera.transform.position - var_188_3.position).y, (manager.ui.mainCamera.transform.position - var_188_3.position).z)
				var_188_3.localEulerAngles.z = 0
				var_188_3.localEulerAngles.x = 0
				var_188_3.localEulerAngles = var_188_3.localEulerAngles
			end

			local var_188_5 = arg_185_1.actors_["10145ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.characterEffect10145ui_story == nil then
				arg_185_1.var_.characterEffect10145ui_story = var_188_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_6 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.characterEffect10145ui_story and not isNil(var_188_5) then
					arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.characterEffect10145ui_story then
				arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_188_8 = 0
			local var_188_9 = 1.3

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(421041046)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 52 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 52)

				if (52 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 52)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041046", "story_v_out_421041.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041046", "story_v_out_421041.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_421041", "421041046", "story_v_out_421041.awb")

						arg_185_1:RecordAudio("421041046", var_188_15)
						arg_185_1:RecordAudio("421041046", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_421041", "421041046", "story_v_out_421041.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_421041", "421041046", "story_v_out_421041.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play421041047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421041047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play421041048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10145ui_story = arg_189_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10145ui_story"].transform.position).z)
				arg_189_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10145ui_story"].transform.localEulerAngles = arg_189_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10145ui_story"].transform.position).z)
				arg_189_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10145ui_story"].transform.localEulerAngles = arg_189_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_192_1 = 0
			local var_192_2 = 0.95

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(421041047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 38 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 38)

				if (38 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 38)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play421041048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421041048
		arg_193_1.duration_ = 1

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"

			SetActive(arg_193_1.choicesGo_, true)

			for iter_194_0, iter_194_1 in ipairs(arg_193_1.choices_) do
				SetActive(iter_194_1.go, iter_194_0 <= 2)
			end

			arg_193_1.choices_[1].txt.text = arg_193_1:FormatText(StoryChoiceCfg[1350].name)
			arg_193_1.choices_[2].txt.text = arg_193_1:FormatText(StoryChoiceCfg[1351].name)
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play421041049(arg_193_1)
			end

			if arg_195_0 == 2 then
				arg_193_0:Play421041049(arg_193_1)
			end

			arg_193_1:RecordChoiceLog(421041048, 1350, 1351)
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			return
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play421041049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421041049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play421041050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.1

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(421041049).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 44 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 44)

				if (44 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 44)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play421041050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421041050
		arg_201_1.duration_ = 6.53

		local var_201_0 = {
			zh = 6.533,
			ja = 4.933
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play421041051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10145ui_story = arg_201_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).z)
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles = arg_201_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_201_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).z)
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles = arg_201_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["10145ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10145ui_story == nil then
				arg_201_1.var_.characterEffect10145ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect10145ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10145ui_story then
				arg_201_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_204_4 = 0
			local var_204_5 = 0.3

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(421041050)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 12 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 12)

				if (12 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 12)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041050", "story_v_out_421041.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041050", "story_v_out_421041.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_421041", "421041050", "story_v_out_421041.awb")

						arg_201_1:RecordAudio("421041050", var_204_11)
						arg_201_1:RecordAudio("421041050", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_421041", "421041050", "story_v_out_421041.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_421041", "421041050", "story_v_out_421041.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play421041051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421041051
		arg_205_1.duration_ = 2.43

		local var_205_0 = {
			zh = 1.999999999999,
			ja = 2.433
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play421041052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1047ui_story = arg_205_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).z)
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles = arg_205_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_205_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).z)
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles = arg_205_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["10145ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10145ui_story = var_208_1.localPosition
			end

			local var_208_2 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 then
				var_208_1.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_205_1.time_ - 0) / var_208_2)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 then
				var_208_1.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			local var_208_3 = arg_205_1.actors_["1047ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect1047ui_story == nil then
				arg_205_1.var_.characterEffect1047ui_story = var_208_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_4 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 and not isNil(var_208_3) then
				if arg_205_1.var_.characterEffect1047ui_story and not isNil(var_208_3) then
					arg_205_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect1047ui_story then
				arg_205_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_208_6 = arg_205_1.actors_["10145ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect10145ui_story == nil then
				arg_205_1.var_.characterEffect10145ui_story = var_208_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_7 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 and not isNil(var_208_6) then
				if arg_205_1.var_.characterEffect10145ui_story and not isNil(var_208_6) then
					arg_205_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_7)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect10145ui_story then
				arg_205_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_208_8 = 0
			local var_208_9 = 0.125

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(421041051)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 5 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 5)

				if (5 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 5)) > 0 and var_208_9 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041051", "story_v_out_421041.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041051", "story_v_out_421041.awb") / 1000

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_421041", "421041051", "story_v_out_421041.awb")

						arg_205_1:RecordAudio("421041051", var_208_15)
						arg_205_1:RecordAudio("421041051", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_421041", "421041051", "story_v_out_421041.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_421041", "421041051", "story_v_out_421041.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_16 and arg_205_1.time_ < var_208_8 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play421041052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421041052
		arg_209_1.duration_ = 8.57

		local var_209_0 = {
			zh = 6.566,
			ja = 8.566
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play421041053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = arg_209_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_1 = 0
			local var_212_2 = 0.75

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(421041052)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 30 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 30)

				if (30 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 30)) > 0 and var_212_2 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041052", "story_v_out_421041.awb") ~= 0 then
					local var_212_7 = manager.audio:GetVoiceLength("story_v_out_421041", "421041052", "story_v_out_421041.awb") / 1000

					if var_212_7 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_1
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_421041", "421041052", "story_v_out_421041.awb")

						arg_209_1:RecordAudio("421041052", var_212_8)
						arg_209_1:RecordAudio("421041052", var_212_8)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421041", "421041052", "story_v_out_421041.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421041", "421041052", "story_v_out_421041.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_9 and arg_209_1.time_ < var_212_1 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play421041053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421041053
		arg_213_1.duration_ = 5

		local var_213_0 = {
			zh = 3.8,
			ja = 5
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play421041054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10145ui_story = arg_213_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).z)
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles = arg_213_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_213_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).z)
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles = arg_213_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1047ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1047ui_story = var_216_1.localPosition
			end

			local var_216_2 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 then
				var_216_1.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_2)
				var_216_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_1.position).x, (manager.ui.mainCamera.transform.position - var_216_1.position).y, (manager.ui.mainCamera.transform.position - var_216_1.position).z)
				var_216_1.localEulerAngles.z = 0
				var_216_1.localEulerAngles.x = 0
				var_216_1.localEulerAngles = var_216_1.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 then
				var_216_1.localPosition = Vector3.New(0, 100, 0)
				var_216_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_1.position).x, (manager.ui.mainCamera.transform.position - var_216_1.position).y, (manager.ui.mainCamera.transform.position - var_216_1.position).z)
				var_216_1.localEulerAngles.z = 0
				var_216_1.localEulerAngles.x = 0
				var_216_1.localEulerAngles = var_216_1.localEulerAngles
			end

			local var_216_3 = arg_213_1.actors_["10145ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect10145ui_story == nil then
				arg_213_1.var_.characterEffect10145ui_story = var_216_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_4 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 and not isNil(var_216_3) then
				if arg_213_1.var_.characterEffect10145ui_story and not isNil(var_216_3) then
					arg_213_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect10145ui_story then
				arg_213_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_216_6 = arg_213_1.actors_["1047ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1047ui_story == nil then
				arg_213_1.var_.characterEffect1047ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect1047ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1047ui_story then
				arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_216_8 = 0
			local var_216_9 = 0.525

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(421041053)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 21 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 21)

				if (21 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 21)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041053", "story_v_out_421041.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041053", "story_v_out_421041.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_421041", "421041053", "story_v_out_421041.awb")

						arg_213_1:RecordAudio("421041053", var_216_15)
						arg_213_1:RecordAudio("421041053", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_421041", "421041053", "story_v_out_421041.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_421041", "421041053", "story_v_out_421041.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play421041054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 421041054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play421041055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10145ui_story = arg_217_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10145ui_story"].transform.position).z)
				arg_217_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10145ui_story"].transform.localEulerAngles = arg_217_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10145ui_story"].transform.position).z)
				arg_217_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10145ui_story"].transform.localEulerAngles = arg_217_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_217_1.time_ and arg_217_1.time_ <= 0.1 + arg_220_0 then
				arg_217_1:AudioAction("play", "effect", "se_story_143", "se_story_143_cardoor", "")
			end

			local var_220_2 = 0
			local var_220_3 = 0.425

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(421041054).content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 17 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 17)

				if (17 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 17)) > 0 and var_220_3 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_7 and arg_217_1.time_ < var_220_2 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play421041055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 421041055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play421041056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.45

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(421041055).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 18 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 18)

				if (18 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 18)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play421041056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 421041056
		arg_225_1.duration_ = 10.53

		local var_225_0 = {
			zh = 6.2,
			ja = 10.533
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play421041057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1047ui_story = arg_225_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1047ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1047ui_story == nil then
				arg_225_1.var_.characterEffect1047ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1047ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1047ui_story then
				arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_228_4 = 0
			local var_228_5 = 0.675

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(421041056)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 27 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 27)

				if (27 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 27)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041056", "story_v_out_421041.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041056", "story_v_out_421041.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_421041", "421041056", "story_v_out_421041.awb")

						arg_225_1:RecordAudio("421041056", var_228_11)
						arg_225_1:RecordAudio("421041056", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_421041", "421041056", "story_v_out_421041.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_421041", "421041056", "story_v_out_421041.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play421041057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 421041057
		arg_229_1.duration_ = 9

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play421041058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if arg_229_1.bgs_.ST2401 == nil then
				local var_232_0 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2401")
				var_232_0.name = "ST2401"
				var_232_0.transform.parent = arg_229_1.stage_.transform
				var_232_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_.ST2401 = var_232_0
			end

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				local var_232_1 = arg_229_1.bgs_.ST2401

				arg_229_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_2 = var_232_1:GetComponent("SpriteRenderer")

				if var_232_2 and var_232_2.sprite then
					local var_232_3 = 2 * (var_232_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_1.transform.localScale = Vector3.New(var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "ST2401" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_4 = 4

			if 4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			if arg_229_1.time_ >= var_232_4 + 0.3 and arg_229_1.time_ < var_232_4 + 0.3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_5 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_6 = 2

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_5) / var_232_6)
				arg_229_1.mask_.color = var_232_7
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 then
				local var_232_8 = Color.New(0, 0, 0)

				var_232_8.a = 1
				arg_229_1.mask_.color = var_232_8
			end

			local var_232_9 = 2

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_10 = 2

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_10 then
				local var_232_11 = Color.New(0, 0, 0)

				var_232_11.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_9) / var_232_10)
				arg_229_1.mask_.color = var_232_11
			end

			if arg_229_1.time_ >= var_232_9 + var_232_10 and arg_229_1.time_ < var_232_9 + var_232_10 + arg_232_0 then
				local var_232_12 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_12.a = 0
				arg_229_1.mask_.color = var_232_12
			end

			local var_232_13 = arg_229_1.actors_["1047ui_story"].transform

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				arg_229_1.var_.moveOldPos1047ui_story = var_232_13.localPosition
			end

			local var_232_14 = 0.001

			if 2 <= arg_229_1.time_ and arg_229_1.time_ < 2 + var_232_14 then
				var_232_13.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 2) / var_232_14)
				var_232_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_13.position).x, (manager.ui.mainCamera.transform.position - var_232_13.position).y, (manager.ui.mainCamera.transform.position - var_232_13.position).z)
				var_232_13.localEulerAngles.z = 0
				var_232_13.localEulerAngles.x = 0
				var_232_13.localEulerAngles = var_232_13.localEulerAngles
			end

			if arg_229_1.time_ >= 2 + var_232_14 and arg_229_1.time_ < 2 + var_232_14 + arg_232_0 then
				var_232_13.localPosition = Vector3.New(0, 100, 0)
				var_232_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_13.position).x, (manager.ui.mainCamera.transform.position - var_232_13.position).y, (manager.ui.mainCamera.transform.position - var_232_13.position).z)
				var_232_13.localEulerAngles.z = 0
				var_232_13.localEulerAngles.x = 0
				var_232_13.localEulerAngles = var_232_13.localEulerAngles
			end

			if 0.2 < arg_229_1.time_ and arg_229_1.time_ <= 0.2 + arg_232_0 then
				arg_229_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_dream01", "")
			end

			if 1.56666666666667 < arg_229_1.time_ and arg_229_1.time_ <= 1.56666666666667 + arg_232_0 then
				arg_229_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_17 = 4
			local var_232_18 = 0.35

			if 4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_17 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_19 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_19:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_20 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(421041057).content)

				arg_229_1.text_.text = var_232_20

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_22 = 14 <= 0 and var_232_18 or var_232_18 * (utf8.len(var_232_20) / 14)

				if (14 <= 0 and var_232_18 or var_232_18 * (utf8.len(var_232_20) / 14)) > 0 and var_232_18 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22
					var_232_17 = var_232_17 + 0.3

					if var_232_22 + var_232_17 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_17
					end
				end

				arg_229_1.text_.text = var_232_20
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_23 = var_232_17 + 0.3
			local var_232_24 = math.max(var_232_18, arg_229_1.talkMaxDuration)

			if var_232_17 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_23 + var_232_24 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_23) / var_232_24

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_23 + var_232_24 and arg_229_1.time_ < var_232_23 + var_232_24 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play421041058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 421041058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play421041059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.15

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(421041058).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 46 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 46)

				if (46 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 46)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play421041059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421041059
		arg_239_1.duration_ = 9.53

		local var_239_0 = {
			zh = 6.2,
			ja = 9.533
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play421041060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1047ui_story = arg_239_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).z)
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles = arg_239_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_239_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1047ui_story"].transform.position).z)
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1047ui_story"].transform.localEulerAngles = arg_239_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1047ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1047ui_story == nil then
				arg_239_1.var_.characterEffect1047ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1047ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1047ui_story then
				arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_242_4 = 0
			local var_242_5 = 0.8

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(421041059)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 32 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 32)

				if (32 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 32)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041059", "story_v_out_421041.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041059", "story_v_out_421041.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_421041", "421041059", "story_v_out_421041.awb")

						arg_239_1:RecordAudio("421041059", var_242_11)
						arg_239_1:RecordAudio("421041059", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_421041", "421041059", "story_v_out_421041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_421041", "421041059", "story_v_out_421041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play421041060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 421041060
		arg_243_1.duration_ = 3.17

		local var_243_0 = {
			zh = 2.5,
			ja = 3.166
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play421041061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1047ui_story = arg_243_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).z)
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles = arg_243_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).z)
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles = arg_243_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["10143ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10143ui_story = var_246_1.localPosition
			end

			local var_246_2 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 then
				var_246_1.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_243_1.time_ - 0) / var_246_2)
				var_246_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_1.position).x, (manager.ui.mainCamera.transform.position - var_246_1.position).y, (manager.ui.mainCamera.transform.position - var_246_1.position).z)
				var_246_1.localEulerAngles.z = 0
				var_246_1.localEulerAngles.x = 0
				var_246_1.localEulerAngles = var_246_1.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 then
				var_246_1.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_246_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_1.position).x, (manager.ui.mainCamera.transform.position - var_246_1.position).y, (manager.ui.mainCamera.transform.position - var_246_1.position).z)
				var_246_1.localEulerAngles.z = 0
				var_246_1.localEulerAngles.x = 0
				var_246_1.localEulerAngles = var_246_1.localEulerAngles
			end

			local var_246_3 = arg_243_1.actors_["10143ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_3) and arg_243_1.var_.characterEffect10143ui_story == nil then
				arg_243_1.var_.characterEffect10143ui_story = var_246_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_4 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 and not isNil(var_246_3) then
				if arg_243_1.var_.characterEffect10143ui_story and not isNil(var_246_3) then
					arg_243_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 and not isNil(var_246_3) and arg_243_1.var_.characterEffect10143ui_story then
				arg_243_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_246_6 = arg_243_1.actors_["1047ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_6) and arg_243_1.var_.characterEffect1047ui_story == nil then
				arg_243_1.var_.characterEffect1047ui_story = var_246_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_7 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 and not isNil(var_246_6) then
				if arg_243_1.var_.characterEffect1047ui_story and not isNil(var_246_6) then
					arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_7)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 and not isNil(var_246_6) and arg_243_1.var_.characterEffect1047ui_story then
				arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_246_8 = 0
			local var_246_9 = 0.25

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(421041060)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 10 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 10)

				if (10 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 10)) > 0 and var_246_9 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041060", "story_v_out_421041.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041060", "story_v_out_421041.awb") / 1000

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end

					if var_246_10.prefab_name ~= "" and arg_243_1.actors_[var_246_10.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_10.prefab_name].transform, "story_v_out_421041", "421041060", "story_v_out_421041.awb")

						arg_243_1:RecordAudio("421041060", var_246_15)
						arg_243_1:RecordAudio("421041060", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_421041", "421041060", "story_v_out_421041.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_421041", "421041060", "story_v_out_421041.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_16 and arg_243_1.time_ < var_246_8 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play421041061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 421041061
		arg_247_1.duration_ = 2.57

		local var_247_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play421041062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10102ui_story = arg_247_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10102ui_story"].transform.position).z)
				arg_247_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10102ui_story"].transform.localEulerAngles = arg_247_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_247_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10102ui_story"].transform.position).z)
				arg_247_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10102ui_story"].transform.localEulerAngles = arg_247_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["10102ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10102ui_story == nil then
				arg_247_1.var_.characterEffect10102ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect10102ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10102ui_story then
				arg_247_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["10143ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect10143ui_story == nil then
				arg_247_1.var_.characterEffect10143ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_5 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 and not isNil(var_250_4) then
				if arg_247_1.var_.characterEffect10143ui_story and not isNil(var_250_4) then
					arg_247_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_5)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect10143ui_story then
				arg_247_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_250_6 = 0
			local var_250_7 = 0.2

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_8 = arg_247_1:GetWordFromCfg(421041061)
				local var_250_9 = arg_247_1:FormatText(var_250_8.content)

				arg_247_1.text_.text = var_250_9

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 8 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_9) / 8)

				if (8 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_9) / 8)) > 0 and var_250_7 < var_250_11 then
					arg_247_1.talkMaxDuration = var_250_11

					if var_250_11 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_9
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041061", "story_v_out_421041.awb") ~= 0 then
					local var_250_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041061", "story_v_out_421041.awb") / 1000

					if var_250_12 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_12 + var_250_6
					end

					if var_250_8.prefab_name ~= "" and arg_247_1.actors_[var_250_8.prefab_name] ~= nil then
						local var_250_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_8.prefab_name].transform, "story_v_out_421041", "421041061", "story_v_out_421041.awb")

						arg_247_1:RecordAudio("421041061", var_250_13)
						arg_247_1:RecordAudio("421041061", var_250_13)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_421041", "421041061", "story_v_out_421041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_421041", "421041061", "story_v_out_421041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_14 and arg_247_1.time_ < var_250_6 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play421041062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 421041062
		arg_251_1.duration_ = 2

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play421041063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10143ui_story = arg_251_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10143ui_story"].transform.position).z)
				arg_251_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10143ui_story"].transform.localEulerAngles = arg_251_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_251_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10143ui_story"].transform.position).z)
				arg_251_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10143ui_story"].transform.localEulerAngles = arg_251_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["10143ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10143ui_story == nil then
				arg_251_1.var_.characterEffect10143ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect10143ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10143ui_story then
				arg_251_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_254_4 = arg_251_1.actors_["10102ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect10102ui_story == nil then
				arg_251_1.var_.characterEffect10102ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_5 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 and not isNil(var_254_4) then
				if arg_251_1.var_.characterEffect10102ui_story and not isNil(var_254_4) then
					arg_251_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_5)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect10102ui_story then
				arg_251_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_254_6 = 0
			local var_254_7 = 0.125

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:GetWordFromCfg(421041062)
				local var_254_9 = arg_251_1:FormatText(var_254_8.content)

				arg_251_1.text_.text = var_254_9

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 5 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 5)

				if (5 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 5)) > 0 and var_254_7 < var_254_11 then
					arg_251_1.talkMaxDuration = var_254_11

					if var_254_11 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_9
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041062", "story_v_out_421041.awb") ~= 0 then
					local var_254_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041062", "story_v_out_421041.awb") / 1000

					if var_254_12 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_6
					end

					if var_254_8.prefab_name ~= "" and arg_251_1.actors_[var_254_8.prefab_name] ~= nil then
						local var_254_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_8.prefab_name].transform, "story_v_out_421041", "421041062", "story_v_out_421041.awb")

						arg_251_1:RecordAudio("421041062", var_254_13)
						arg_251_1:RecordAudio("421041062", var_254_13)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_421041", "421041062", "story_v_out_421041.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_421041", "421041062", "story_v_out_421041.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play421041063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 421041063
		arg_255_1.duration_ = 7.63

		local var_255_0 = {
			zh = 5.9,
			ja = 7.633
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play421041064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10102ui_story = arg_255_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).z)
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles = arg_255_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_255_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).z)
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles = arg_255_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["10102ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10102ui_story == nil then
				arg_255_1.var_.characterEffect10102ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect10102ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10102ui_story then
				arg_255_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["10143ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect10143ui_story == nil then
				arg_255_1.var_.characterEffect10143ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_5 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_5 and not isNil(var_258_4) then
				if arg_255_1.var_.characterEffect10143ui_story and not isNil(var_258_4) then
					arg_255_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_5)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_5 and arg_255_1.time_ < 0 + var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect10143ui_story then
				arg_255_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_6 = 0
			local var_258_7 = 0.7

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_8 = arg_255_1:GetWordFromCfg(421041063)
				local var_258_9 = arg_255_1:FormatText(var_258_8.content)

				arg_255_1.text_.text = var_258_9

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 28 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 28)

				if (28 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 28)) > 0 and var_258_7 < var_258_11 then
					arg_255_1.talkMaxDuration = var_258_11

					if var_258_11 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_9
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041063", "story_v_out_421041.awb") ~= 0 then
					local var_258_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041063", "story_v_out_421041.awb") / 1000

					if var_258_12 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_6
					end

					if var_258_8.prefab_name ~= "" and arg_255_1.actors_[var_258_8.prefab_name] ~= nil then
						local var_258_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_8.prefab_name].transform, "story_v_out_421041", "421041063", "story_v_out_421041.awb")

						arg_255_1:RecordAudio("421041063", var_258_13)
						arg_255_1:RecordAudio("421041063", var_258_13)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_421041", "421041063", "story_v_out_421041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_421041", "421041063", "story_v_out_421041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play421041064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 421041064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play421041065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10102ui_story"]) and arg_259_1.var_.characterEffect10102ui_story == nil then
				arg_259_1.var_.characterEffect10102ui_story = arg_259_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10102ui_story"]) then
				if arg_259_1.var_.characterEffect10102ui_story and not isNil(arg_259_1.actors_["10102ui_story"]) then
					arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10102ui_story"]) and arg_259_1.var_.characterEffect10102ui_story then
				arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.25

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(421041064).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 10 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 10)

				if (10 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 10)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play421041065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 421041065
		arg_263_1.duration_ = 3.1

		local var_263_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play421041066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10143ui_story = arg_263_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10143ui_story"].transform.position).z)
				arg_263_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10143ui_story"].transform.localEulerAngles = arg_263_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_263_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10143ui_story"].transform.position).z)
				arg_263_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10143ui_story"].transform.localEulerAngles = arg_263_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["10143ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10143ui_story == nil then
				arg_263_1.var_.characterEffect10143ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect10143ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10143ui_story then
				arg_263_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_266_4 = 0
			local var_266_5 = 0.15

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(421041065)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 6 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 6)

				if (6 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 6)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041065", "story_v_out_421041.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041065", "story_v_out_421041.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_421041", "421041065", "story_v_out_421041.awb")

						arg_263_1:RecordAudio("421041065", var_266_11)
						arg_263_1:RecordAudio("421041065", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_421041", "421041065", "story_v_out_421041.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_421041", "421041065", "story_v_out_421041.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play421041066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 421041066
		arg_267_1.duration_ = 7.9

		local var_267_0 = {
			zh = 6.7,
			ja = 7.9
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play421041067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10102ui_story = arg_267_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10102ui_story"].transform.position).z)
				arg_267_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["10102ui_story"].transform.localEulerAngles = arg_267_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_267_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10102ui_story"].transform.position).z)
				arg_267_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["10102ui_story"].transform.localEulerAngles = arg_267_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["10102ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10102ui_story == nil then
				arg_267_1.var_.characterEffect10102ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect10102ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10102ui_story then
				arg_267_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["10143ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect10143ui_story == nil then
				arg_267_1.var_.characterEffect10143ui_story = var_270_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_5 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_5 and not isNil(var_270_4) then
				if arg_267_1.var_.characterEffect10143ui_story and not isNil(var_270_4) then
					arg_267_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_5)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_5 and arg_267_1.time_ < 0 + var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect10143ui_story then
				arg_267_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_270_6 = 0
			local var_270_7 = 0.75

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_8 = arg_267_1:GetWordFromCfg(421041066)
				local var_270_9 = arg_267_1:FormatText(var_270_8.content)

				arg_267_1.text_.text = var_270_9

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_11 = 30 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 30)

				if (30 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 30)) > 0 and var_270_7 < var_270_11 then
					arg_267_1.talkMaxDuration = var_270_11

					if var_270_11 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_9
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041066", "story_v_out_421041.awb") ~= 0 then
					local var_270_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041066", "story_v_out_421041.awb") / 1000

					if var_270_12 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_6
					end

					if var_270_8.prefab_name ~= "" and arg_267_1.actors_[var_270_8.prefab_name] ~= nil then
						local var_270_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_8.prefab_name].transform, "story_v_out_421041", "421041066", "story_v_out_421041.awb")

						arg_267_1:RecordAudio("421041066", var_270_13)
						arg_267_1:RecordAudio("421041066", var_270_13)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_421041", "421041066", "story_v_out_421041.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_421041", "421041066", "story_v_out_421041.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_14 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_14 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_14

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_14 and arg_267_1.time_ < var_270_6 + var_270_14 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play421041067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 421041067
		arg_271_1.duration_ = 2.23

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play421041068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10143ui_story = arg_271_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10143ui_story"].transform.position).z)
				arg_271_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10143ui_story"].transform.localEulerAngles = arg_271_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_271_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10143ui_story"].transform.position).z)
				arg_271_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10143ui_story"].transform.localEulerAngles = arg_271_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["10143ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect10143ui_story == nil then
				arg_271_1.var_.characterEffect10143ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect10143ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect10143ui_story then
				arg_271_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_274_4 = arg_271_1.actors_["10102ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect10102ui_story == nil then
				arg_271_1.var_.characterEffect10102ui_story = var_274_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_5 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_5 and not isNil(var_274_4) then
				if arg_271_1.var_.characterEffect10102ui_story and not isNil(var_274_4) then
					arg_271_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_5)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_5 and arg_271_1.time_ < 0 + var_274_5 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect10102ui_story then
				arg_271_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_274_6 = 0
			local var_274_7 = 0.2

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(421041067)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 8 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 8)

				if (8 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 8)) > 0 and var_274_7 < var_274_11 then
					arg_271_1.talkMaxDuration = var_274_11

					if var_274_11 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041067", "story_v_out_421041.awb") ~= 0 then
					local var_274_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041067", "story_v_out_421041.awb") / 1000

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end

					if var_274_8.prefab_name ~= "" and arg_271_1.actors_[var_274_8.prefab_name] ~= nil then
						local var_274_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_8.prefab_name].transform, "story_v_out_421041", "421041067", "story_v_out_421041.awb")

						arg_271_1:RecordAudio("421041067", var_274_13)
						arg_271_1:RecordAudio("421041067", var_274_13)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_421041", "421041067", "story_v_out_421041.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_421041", "421041067", "story_v_out_421041.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_14 and arg_271_1.time_ < var_274_6 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play421041068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 421041068
		arg_275_1.duration_ = 7.87

		local var_275_0 = {
			zh = 7.866,
			ja = 7.466
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play421041069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10145ui_story = arg_275_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).z)
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles = arg_275_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_275_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).z)
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles = arg_275_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["10102ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10102ui_story = var_278_1.localPosition
			end

			local var_278_2 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 then
				var_278_1.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_2)
				var_278_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_1.position).x, (manager.ui.mainCamera.transform.position - var_278_1.position).y, (manager.ui.mainCamera.transform.position - var_278_1.position).z)
				var_278_1.localEulerAngles.z = 0
				var_278_1.localEulerAngles.x = 0
				var_278_1.localEulerAngles = var_278_1.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 then
				var_278_1.localPosition = Vector3.New(0, 100, 0)
				var_278_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_1.position).x, (manager.ui.mainCamera.transform.position - var_278_1.position).y, (manager.ui.mainCamera.transform.position - var_278_1.position).z)
				var_278_1.localEulerAngles.z = 0
				var_278_1.localEulerAngles.x = 0
				var_278_1.localEulerAngles = var_278_1.localEulerAngles
			end

			local var_278_3 = arg_275_1.actors_["10145ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_3) and arg_275_1.var_.characterEffect10145ui_story == nil then
				arg_275_1.var_.characterEffect10145ui_story = var_278_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_4 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 and not isNil(var_278_3) then
				if arg_275_1.var_.characterEffect10145ui_story and not isNil(var_278_3) then
					arg_275_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 and not isNil(var_278_3) and arg_275_1.var_.characterEffect10145ui_story then
				arg_275_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_278_6 = arg_275_1.actors_["10143ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect10143ui_story == nil then
				arg_275_1.var_.characterEffect10143ui_story = var_278_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_7 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 and not isNil(var_278_6) then
				if arg_275_1.var_.characterEffect10143ui_story and not isNil(var_278_6) then
					arg_275_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_7)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect10143ui_story then
				arg_275_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_278_8 = 0
			local var_278_9 = 0.775

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(421041068)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 31 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 31)

				if (31 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 31)) > 0 and var_278_9 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041068", "story_v_out_421041.awb") ~= 0 then
					local var_278_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041068", "story_v_out_421041.awb") / 1000

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end

					if var_278_10.prefab_name ~= "" and arg_275_1.actors_[var_278_10.prefab_name] ~= nil then
						local var_278_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_10.prefab_name].transform, "story_v_out_421041", "421041068", "story_v_out_421041.awb")

						arg_275_1:RecordAudio("421041068", var_278_15)
						arg_275_1:RecordAudio("421041068", var_278_15)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_421041", "421041068", "story_v_out_421041.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_421041", "421041068", "story_v_out_421041.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_16 and arg_275_1.time_ < var_278_8 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play421041069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 421041069
		arg_279_1.duration_ = 2.83

		local var_279_0 = {
			zh = 2.166,
			ja = 2.833
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play421041070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10143ui_story = arg_279_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10143ui_story"].transform.position).z)
				arg_279_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10143ui_story"].transform.localEulerAngles = arg_279_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_279_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10143ui_story"].transform.position).z)
				arg_279_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10143ui_story"].transform.localEulerAngles = arg_279_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["10143ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10143ui_story == nil then
				arg_279_1.var_.characterEffect10143ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect10143ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10143ui_story then
				arg_279_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_282_4 = arg_279_1.actors_["10145ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect10145ui_story == nil then
				arg_279_1.var_.characterEffect10145ui_story = var_282_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_5 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_5 and not isNil(var_282_4) then
				if arg_279_1.var_.characterEffect10145ui_story and not isNil(var_282_4) then
					arg_279_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_5)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_5 and arg_279_1.time_ < 0 + var_282_5 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect10145ui_story then
				arg_279_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action5_1")
			end

			local var_282_6 = 0
			local var_282_7 = 0.325

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_8 = arg_279_1:GetWordFromCfg(421041069)
				local var_282_9 = arg_279_1:FormatText(var_282_8.content)

				arg_279_1.text_.text = var_282_9

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 13 <= 0 and var_282_7 or var_282_7 * (utf8.len(var_282_9) / 13)

				if (13 <= 0 and var_282_7 or var_282_7 * (utf8.len(var_282_9) / 13)) > 0 and var_282_7 < var_282_11 then
					arg_279_1.talkMaxDuration = var_282_11

					if var_282_11 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_9
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041069", "story_v_out_421041.awb") ~= 0 then
					local var_282_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041069", "story_v_out_421041.awb") / 1000

					if var_282_12 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_12 + var_282_6
					end

					if var_282_8.prefab_name ~= "" and arg_279_1.actors_[var_282_8.prefab_name] ~= nil then
						local var_282_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_8.prefab_name].transform, "story_v_out_421041", "421041069", "story_v_out_421041.awb")

						arg_279_1:RecordAudio("421041069", var_282_13)
						arg_279_1:RecordAudio("421041069", var_282_13)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_421041", "421041069", "story_v_out_421041.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_421041", "421041069", "story_v_out_421041.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_14 and arg_279_1.time_ < var_282_6 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play421041070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 421041070
		arg_283_1.duration_ = 4.5

		local var_283_0 = {
			zh = 3.9,
			ja = 4.5
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play421041071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10145ui_story = arg_283_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10145ui_story"].transform.position).z)
				arg_283_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10145ui_story"].transform.localEulerAngles = arg_283_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_283_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10145ui_story"].transform.position).z)
				arg_283_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10145ui_story"].transform.localEulerAngles = arg_283_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["10145ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10145ui_story == nil then
				arg_283_1.var_.characterEffect10145ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect10145ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10145ui_story then
				arg_283_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_286_4 = arg_283_1.actors_["10143ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect10143ui_story == nil then
				arg_283_1.var_.characterEffect10143ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_5 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 and not isNil(var_286_4) then
				if arg_283_1.var_.characterEffect10143ui_story and not isNil(var_286_4) then
					arg_283_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_5)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect10143ui_story then
				arg_283_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_286_6 = 0
			local var_286_7 = 0.4

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:GetWordFromCfg(421041070)
				local var_286_9 = arg_283_1:FormatText(var_286_8.content)

				arg_283_1.text_.text = var_286_9

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 16 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 16)

				if (16 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 16)) > 0 and var_286_7 < var_286_11 then
					arg_283_1.talkMaxDuration = var_286_11

					if var_286_11 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_9
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041070", "story_v_out_421041.awb") ~= 0 then
					local var_286_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041070", "story_v_out_421041.awb") / 1000

					if var_286_12 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_6
					end

					if var_286_8.prefab_name ~= "" and arg_283_1.actors_[var_286_8.prefab_name] ~= nil then
						local var_286_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_8.prefab_name].transform, "story_v_out_421041", "421041070", "story_v_out_421041.awb")

						arg_283_1:RecordAudio("421041070", var_286_13)
						arg_283_1:RecordAudio("421041070", var_286_13)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_421041", "421041070", "story_v_out_421041.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_421041", "421041070", "story_v_out_421041.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play421041071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 421041071
		arg_287_1.duration_ = 6.77

		local var_287_0 = {
			zh = 4.733,
			ja = 6.766
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play421041072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10143ui_story = arg_287_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10143ui_story"].transform.position).z)
				arg_287_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10143ui_story"].transform.localEulerAngles = arg_287_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_287_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10143ui_story"].transform.position).z)
				arg_287_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10143ui_story"].transform.localEulerAngles = arg_287_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["10143ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10143ui_story == nil then
				arg_287_1.var_.characterEffect10143ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect10143ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10143ui_story then
				arg_287_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_290_4 = arg_287_1.actors_["10145ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect10145ui_story == nil then
				arg_287_1.var_.characterEffect10145ui_story = var_290_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_5 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 and not isNil(var_290_4) then
				if arg_287_1.var_.characterEffect10145ui_story and not isNil(var_290_4) then
					arg_287_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_5)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect10145ui_story then
				arg_287_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action5_2")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_290_6 = 0
			local var_290_7 = 0.55

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_8 = arg_287_1:GetWordFromCfg(421041071)
				local var_290_9 = arg_287_1:FormatText(var_290_8.content)

				arg_287_1.text_.text = var_290_9

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 22 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 22)

				if (22 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 22)) > 0 and var_290_7 < var_290_11 then
					arg_287_1.talkMaxDuration = var_290_11

					if var_290_11 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_9
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041071", "story_v_out_421041.awb") ~= 0 then
					local var_290_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041071", "story_v_out_421041.awb") / 1000

					if var_290_12 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_6
					end

					if var_290_8.prefab_name ~= "" and arg_287_1.actors_[var_290_8.prefab_name] ~= nil then
						local var_290_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_8.prefab_name].transform, "story_v_out_421041", "421041071", "story_v_out_421041.awb")

						arg_287_1:RecordAudio("421041071", var_290_13)
						arg_287_1:RecordAudio("421041071", var_290_13)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_421041", "421041071", "story_v_out_421041.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_421041", "421041071", "story_v_out_421041.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_14 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_14

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_14 and arg_287_1.time_ < var_290_6 + var_290_14 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play421041072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 421041072
		arg_291_1.duration_ = 3.7

		local var_291_0 = {
			zh = 3.4,
			ja = 3.7
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play421041073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10145ui_story = arg_291_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10145ui_story"].transform.position).z)
				arg_291_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["10145ui_story"].transform.localEulerAngles = arg_291_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_291_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10145ui_story"].transform.position).z)
				arg_291_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["10145ui_story"].transform.localEulerAngles = arg_291_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["10145ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10145ui_story == nil then
				arg_291_1.var_.characterEffect10145ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect10145ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10145ui_story then
				arg_291_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_294_4 = arg_291_1.actors_["10143ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10143ui_story == nil then
				arg_291_1.var_.characterEffect10143ui_story = var_294_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_5 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_5 and not isNil(var_294_4) then
				if arg_291_1.var_.characterEffect10143ui_story and not isNil(var_294_4) then
					arg_291_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_5)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_5 and arg_291_1.time_ < 0 + var_294_5 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10143ui_story then
				arg_291_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			local var_294_6 = 0
			local var_294_7 = 0.275

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_8 = arg_291_1:GetWordFromCfg(421041072)
				local var_294_9 = arg_291_1:FormatText(var_294_8.content)

				arg_291_1.text_.text = var_294_9

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 11 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 11)

				if (11 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 11)) > 0 and var_294_7 < var_294_11 then
					arg_291_1.talkMaxDuration = var_294_11

					if var_294_11 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_9
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041072", "story_v_out_421041.awb") ~= 0 then
					local var_294_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041072", "story_v_out_421041.awb") / 1000

					if var_294_12 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_6
					end

					if var_294_8.prefab_name ~= "" and arg_291_1.actors_[var_294_8.prefab_name] ~= nil then
						local var_294_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_8.prefab_name].transform, "story_v_out_421041", "421041072", "story_v_out_421041.awb")

						arg_291_1:RecordAudio("421041072", var_294_13)
						arg_291_1:RecordAudio("421041072", var_294_13)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_421041", "421041072", "story_v_out_421041.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_421041", "421041072", "story_v_out_421041.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_14 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_14 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_14

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_14 and arg_291_1.time_ < var_294_6 + var_294_14 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play421041073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 421041073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play421041074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10143ui_story = arg_295_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10143ui_story"].transform.position).z)
				arg_295_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10143ui_story"].transform.localEulerAngles = arg_295_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10143ui_story"].transform.position).z)
				arg_295_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10143ui_story"].transform.localEulerAngles = arg_295_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["10145ui_story"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10145ui_story = var_298_1.localPosition
			end

			local var_298_2 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 then
				var_298_1.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_2)
				var_298_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_1.position).x, (manager.ui.mainCamera.transform.position - var_298_1.position).y, (manager.ui.mainCamera.transform.position - var_298_1.position).z)
				var_298_1.localEulerAngles.z = 0
				var_298_1.localEulerAngles.x = 0
				var_298_1.localEulerAngles = var_298_1.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 then
				var_298_1.localPosition = Vector3.New(0, 100, 0)
				var_298_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_1.position).x, (manager.ui.mainCamera.transform.position - var_298_1.position).y, (manager.ui.mainCamera.transform.position - var_298_1.position).z)
				var_298_1.localEulerAngles.z = 0
				var_298_1.localEulerAngles.x = 0
				var_298_1.localEulerAngles = var_298_1.localEulerAngles
			end

			local var_298_3 = 0
			local var_298_4 = 1.075

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_3 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_5 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(421041073).content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 43 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 43)

				if (43 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 43)) > 0 and var_298_4 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_3 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_3
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_4, arg_295_1.talkMaxDuration)

			if var_298_3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_3 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_3) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_3 + var_298_8 and arg_295_1.time_ < var_298_3 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play421041074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 421041074
		arg_299_1.duration_ = 9

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play421041075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if arg_299_1.bgs_.ST0110 == nil then
				local var_302_0 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0110")
				var_302_0.name = "ST0110"
				var_302_0.transform.parent = arg_299_1.stage_.transform
				var_302_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_.ST0110 = var_302_0
			end

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= 2 + arg_302_0 then
				local var_302_1 = arg_299_1.bgs_.ST0110

				arg_299_1.bgs_.ST0110.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_2 = var_302_1:GetComponent("SpriteRenderer")

				if var_302_2 and var_302_2.sprite then
					local var_302_3 = 2 * (var_302_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_1.transform.localScale = Vector3.New(var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "ST0110" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_4 = 4

			if 4 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.allBtn_.enabled = false
			end

			if arg_299_1.time_ >= var_302_4 + 0.3 and arg_299_1.time_ < var_302_4 + 0.3 + arg_302_0 then
				arg_299_1.allBtn_.enabled = true
			end

			local var_302_5 = 0

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_6 = 2

			if var_302_5 <= arg_299_1.time_ and arg_299_1.time_ < var_302_5 + var_302_6 then
				local var_302_7 = Color.New(0, 0, 0)

				var_302_7.a = Mathf.Lerp(0, 1, (arg_299_1.time_ - var_302_5) / var_302_6)
				arg_299_1.mask_.color = var_302_7
			end

			if arg_299_1.time_ >= var_302_5 + var_302_6 and arg_299_1.time_ < var_302_5 + var_302_6 + arg_302_0 then
				local var_302_8 = Color.New(0, 0, 0)

				var_302_8.a = 1
				arg_299_1.mask_.color = var_302_8
			end

			local var_302_9 = 2

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_10 = 2

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_10 then
				local var_302_11 = Color.New(0, 0, 0)

				var_302_11.a = Mathf.Lerp(1, 0, (arg_299_1.time_ - var_302_9) / var_302_10)
				arg_299_1.mask_.color = var_302_11
			end

			if arg_299_1.time_ >= var_302_9 + var_302_10 and arg_299_1.time_ < var_302_9 + var_302_10 + arg_302_0 then
				local var_302_12 = Color.New(0, 0, 0)

				arg_299_1.mask_.enabled = false
				var_302_12.a = 0
				arg_299_1.mask_.color = var_302_12
			end

			if 0.1 < arg_299_1.time_ and arg_299_1.time_ <= 0.1 + arg_302_0 then
				arg_299_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if 1.66666666666667 < arg_299_1.time_ and arg_299_1.time_ <= 1.66666666666667 + arg_302_0 then
				arg_299_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_299_1.frameCnt_ <= 1 then
				arg_299_1.dialog_:SetActive(false)
			end

			local var_302_15 = 4
			local var_302_16 = 2.125

			if 4 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_17 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_17:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(421041074).content)

				arg_299_1.text_.text = var_302_18

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 85 <= 0 and var_302_16 or var_302_16 * (utf8.len(var_302_18) / 85)

				if (85 <= 0 and var_302_16 or var_302_16 * (utf8.len(var_302_18) / 85)) > 0 and var_302_16 < var_302_20 then
					arg_299_1.talkMaxDuration = var_302_20
					var_302_15 = var_302_15 + 0.3

					if var_302_20 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_18
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_21 = var_302_15 + 0.3
			local var_302_22 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 + 0.3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_21 + var_302_22 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_21) / var_302_22

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_21 + var_302_22 and arg_299_1.time_ < var_302_21 + var_302_22 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play421041075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 421041075
		arg_305_1.duration_ = 2.97

		local var_305_0 = {
			zh = 1.999999999999,
			ja = 2.966
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play421041076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos10102ui_story = arg_305_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).z)
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles = arg_305_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_305_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).z)
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles = arg_305_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["10102ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect10102ui_story == nil then
				arg_305_1.var_.characterEffect10102ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect10102ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect10102ui_story then
				arg_305_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_308_4 = 0
			local var_308_5 = 0.175

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(421041075)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 7 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 7)

				if (7 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 7)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041075", "story_v_out_421041.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041075", "story_v_out_421041.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_out_421041", "421041075", "story_v_out_421041.awb")

						arg_305_1:RecordAudio("421041075", var_308_11)
						arg_305_1:RecordAudio("421041075", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_421041", "421041075", "story_v_out_421041.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_421041", "421041075", "story_v_out_421041.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play421041076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 421041076
		arg_309_1.duration_ = 5.43

		local var_309_0 = {
			zh = 2.933,
			ja = 5.433
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play421041077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10145ui_story = arg_309_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10145ui_story"].transform.position).z)
				arg_309_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["10145ui_story"].transform.localEulerAngles = arg_309_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_309_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10145ui_story"].transform.position).z)
				arg_309_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["10145ui_story"].transform.localEulerAngles = arg_309_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["10102ui_story"].transform

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10102ui_story = var_312_1.localPosition
			end

			local var_312_2 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 then
				var_312_1.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 0) / var_312_2)
				var_312_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_1.position).x, (manager.ui.mainCamera.transform.position - var_312_1.position).y, (manager.ui.mainCamera.transform.position - var_312_1.position).z)
				var_312_1.localEulerAngles.z = 0
				var_312_1.localEulerAngles.x = 0
				var_312_1.localEulerAngles = var_312_1.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 then
				var_312_1.localPosition = Vector3.New(0, 100, 0)
				var_312_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_312_1.position).x, (manager.ui.mainCamera.transform.position - var_312_1.position).y, (manager.ui.mainCamera.transform.position - var_312_1.position).z)
				var_312_1.localEulerAngles.z = 0
				var_312_1.localEulerAngles.x = 0
				var_312_1.localEulerAngles = var_312_1.localEulerAngles
			end

			local var_312_3 = arg_309_1.actors_["10145ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_3) and arg_309_1.var_.characterEffect10145ui_story == nil then
				arg_309_1.var_.characterEffect10145ui_story = var_312_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_4 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 and not isNil(var_312_3) then
				if arg_309_1.var_.characterEffect10145ui_story and not isNil(var_312_3) then
					arg_309_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 and not isNil(var_312_3) and arg_309_1.var_.characterEffect10145ui_story then
				arg_309_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_312_6 = arg_309_1.actors_["10102ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect10102ui_story == nil then
				arg_309_1.var_.characterEffect10102ui_story = var_312_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_7 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 and not isNil(var_312_6) then
				if arg_309_1.var_.characterEffect10102ui_story and not isNil(var_312_6) then
					arg_309_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_7)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect10102ui_story then
				arg_309_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_312_8 = 0
			local var_312_9 = 0.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_10 = arg_309_1:GetWordFromCfg(421041076)
				local var_312_11 = arg_309_1:FormatText(var_312_10.content)

				arg_309_1.text_.text = var_312_11

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_13 = 12 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 12)

				if (12 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 12)) > 0 and var_312_9 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_8
					end
				end

				arg_309_1.text_.text = var_312_11
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041076", "story_v_out_421041.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041076", "story_v_out_421041.awb") / 1000

					if var_312_14 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_8
					end

					if var_312_10.prefab_name ~= "" and arg_309_1.actors_[var_312_10.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_10.prefab_name].transform, "story_v_out_421041", "421041076", "story_v_out_421041.awb")

						arg_309_1:RecordAudio("421041076", var_312_15)
						arg_309_1:RecordAudio("421041076", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_421041", "421041076", "story_v_out_421041.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_421041", "421041076", "story_v_out_421041.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_9, arg_309_1.talkMaxDuration)

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_8) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_8 + var_312_16 and arg_309_1.time_ < var_312_8 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play421041077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 421041077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play421041078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["10145ui_story"]) and arg_313_1.var_.characterEffect10145ui_story == nil then
				arg_313_1.var_.characterEffect10145ui_story = arg_313_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["10145ui_story"]) then
				if arg_313_1.var_.characterEffect10145ui_story and not isNil(arg_313_1.actors_["10145ui_story"]) then
					arg_313_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_313_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["10145ui_story"]) and arg_313_1.var_.characterEffect10145ui_story then
				arg_313_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_313_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.125

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(421041077).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 5 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 5)

				if (5 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 5)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play421041078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 421041078
		arg_317_1.duration_ = 11.5

		local var_317_0 = {
			zh = 9.233,
			ja = 11.5
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play421041079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10145ui_story"]) and arg_317_1.var_.characterEffect10145ui_story == nil then
				arg_317_1.var_.characterEffect10145ui_story = arg_317_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10145ui_story"]) then
				if arg_317_1.var_.characterEffect10145ui_story and not isNil(arg_317_1.actors_["10145ui_story"]) then
					arg_317_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10145ui_story"]) and arg_317_1.var_.characterEffect10145ui_story then
				arg_317_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_320_2 = 0
			local var_320_3 = 1.125

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_4 = arg_317_1:GetWordFromCfg(421041078)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 45 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 45)

				if (45 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 45)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041078", "story_v_out_421041.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041078", "story_v_out_421041.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_out_421041", "421041078", "story_v_out_421041.awb")

						arg_317_1:RecordAudio("421041078", var_320_9)
						arg_317_1:RecordAudio("421041078", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_421041", "421041078", "story_v_out_421041.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_421041", "421041078", "story_v_out_421041.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_10 and arg_317_1.time_ < var_320_2 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play421041079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 421041079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play421041080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10145ui_story"]) and arg_321_1.var_.characterEffect10145ui_story == nil then
				arg_321_1.var_.characterEffect10145ui_story = arg_321_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10145ui_story"]) then
				if arg_321_1.var_.characterEffect10145ui_story and not isNil(arg_321_1.actors_["10145ui_story"]) then
					arg_321_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_321_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10145ui_story"]) and arg_321_1.var_.characterEffect10145ui_story then
				arg_321_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_321_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 0.525

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(421041079).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 21 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 21)

				if (21 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 21)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play421041080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 421041080
		arg_325_1.duration_ = 12.23

		local var_325_0 = {
			zh = 11.666,
			ja = 12.233
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play421041081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10145ui_story"]) and arg_325_1.var_.characterEffect10145ui_story == nil then
				arg_325_1.var_.characterEffect10145ui_story = arg_325_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10145ui_story"]) then
				if arg_325_1.var_.characterEffect10145ui_story and not isNil(arg_325_1.actors_["10145ui_story"]) then
					arg_325_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10145ui_story"]) and arg_325_1.var_.characterEffect10145ui_story then
				arg_325_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_328_2 = 0
			local var_328_3 = 1.325

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(421041080)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 54 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 54)

				if (54 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 54)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041080", "story_v_out_421041.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041080", "story_v_out_421041.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_out_421041", "421041080", "story_v_out_421041.awb")

						arg_325_1:RecordAudio("421041080", var_328_9)
						arg_325_1:RecordAudio("421041080", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_421041", "421041080", "story_v_out_421041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_421041", "421041080", "story_v_out_421041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play421041081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 421041081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play421041082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10145ui_story"]) and arg_329_1.var_.characterEffect10145ui_story == nil then
				arg_329_1.var_.characterEffect10145ui_story = arg_329_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10145ui_story"]) then
				if arg_329_1.var_.characterEffect10145ui_story and not isNil(arg_329_1.actors_["10145ui_story"]) then
					arg_329_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10145ui_story"]) and arg_329_1.var_.characterEffect10145ui_story then
				arg_329_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.3

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(421041081).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 12 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 12)

				if (12 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 12)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play421041082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 421041082
		arg_333_1.duration_ = 2.67

		local var_333_0 = {
			zh = 2.666,
			ja = 2
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play421041083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1047ui_story = arg_333_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).z)
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles = arg_333_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_333_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).z)
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles = arg_333_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1047ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1047ui_story == nil then
				arg_333_1.var_.characterEffect1047ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1047ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1047ui_story then
				arg_333_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_336_4 = arg_333_1.actors_["10145ui_story"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10145ui_story = var_336_4.localPosition
			end

			local var_336_5 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_5 then
				var_336_4.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 0) / var_336_5)
				var_336_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_4.position).x, (manager.ui.mainCamera.transform.position - var_336_4.position).y, (manager.ui.mainCamera.transform.position - var_336_4.position).z)
				var_336_4.localEulerAngles.z = 0
				var_336_4.localEulerAngles.x = 0
				var_336_4.localEulerAngles = var_336_4.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_5 and arg_333_1.time_ < 0 + var_336_5 + arg_336_0 then
				var_336_4.localPosition = Vector3.New(0, 100, 0)
				var_336_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_4.position).x, (manager.ui.mainCamera.transform.position - var_336_4.position).y, (manager.ui.mainCamera.transform.position - var_336_4.position).z)
				var_336_4.localEulerAngles.z = 0
				var_336_4.localEulerAngles.x = 0
				var_336_4.localEulerAngles = var_336_4.localEulerAngles
			end

			local var_336_6 = 0
			local var_336_7 = 0.2

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_8 = arg_333_1:GetWordFromCfg(421041082)
				local var_336_9 = arg_333_1:FormatText(var_336_8.content)

				arg_333_1.text_.text = var_336_9

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 8 <= 0 and var_336_7 or var_336_7 * (utf8.len(var_336_9) / 8)

				if (8 <= 0 and var_336_7 or var_336_7 * (utf8.len(var_336_9) / 8)) > 0 and var_336_7 < var_336_11 then
					arg_333_1.talkMaxDuration = var_336_11

					if var_336_11 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_9
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041082", "story_v_out_421041.awb") ~= 0 then
					local var_336_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041082", "story_v_out_421041.awb") / 1000

					if var_336_12 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_12 + var_336_6
					end

					if var_336_8.prefab_name ~= "" and arg_333_1.actors_[var_336_8.prefab_name] ~= nil then
						local var_336_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_8.prefab_name].transform, "story_v_out_421041", "421041082", "story_v_out_421041.awb")

						arg_333_1:RecordAudio("421041082", var_336_13)
						arg_333_1:RecordAudio("421041082", var_336_13)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_421041", "421041082", "story_v_out_421041.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_421041", "421041082", "story_v_out_421041.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play421041083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 421041083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play421041084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1047ui_story"]) and arg_337_1.var_.characterEffect1047ui_story == nil then
				arg_337_1.var_.characterEffect1047ui_story = arg_337_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1047ui_story"]) then
				if arg_337_1.var_.characterEffect1047ui_story and not isNil(arg_337_1.actors_["1047ui_story"]) then
					arg_337_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1047ui_story"]) and arg_337_1.var_.characterEffect1047ui_story then
				arg_337_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.35

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(421041083).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 14 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 14)

				if (14 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 14)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play421041084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 421041084
		arg_341_1.duration_ = 15.6

		local var_341_0 = {
			zh = 11.666,
			ja = 15.6
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play421041085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1047ui_story = arg_341_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).z)
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles = arg_341_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_341_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).z)
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles = arg_341_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1047ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1047ui_story == nil then
				arg_341_1.var_.characterEffect1047ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1047ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1047ui_story then
				arg_341_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_344_4 = 0
			local var_344_5 = 1.5

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(421041084)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 60 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 60)

				if (60 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 60)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041084", "story_v_out_421041.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041084", "story_v_out_421041.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_421041", "421041084", "story_v_out_421041.awb")

						arg_341_1:RecordAudio("421041084", var_344_11)
						arg_341_1:RecordAudio("421041084", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_421041", "421041084", "story_v_out_421041.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_421041", "421041084", "story_v_out_421041.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play421041085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 421041085
		arg_345_1.duration_ = 7.13

		local var_345_0 = {
			zh = 6.933,
			ja = 7.133
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play421041086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10145ui_story = arg_345_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10145ui_story"].transform.position).z)
				arg_345_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["10145ui_story"].transform.localEulerAngles = arg_345_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_345_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10145ui_story"].transform.position).z)
				arg_345_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["10145ui_story"].transform.localEulerAngles = arg_345_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["10145ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect10145ui_story == nil then
				arg_345_1.var_.characterEffect10145ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect10145ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect10145ui_story then
				arg_345_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_348_4 = arg_345_1.actors_["1047ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect1047ui_story == nil then
				arg_345_1.var_.characterEffect1047ui_story = var_348_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_5 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_5 and not isNil(var_348_4) then
				if arg_345_1.var_.characterEffect1047ui_story and not isNil(var_348_4) then
					arg_345_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_5)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_5 and arg_345_1.time_ < 0 + var_348_5 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect1047ui_story then
				arg_345_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_348_6 = arg_345_1.actors_["1047ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1047ui_story = var_348_6.localPosition
			end

			local var_348_7 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				var_348_6.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_345_1.time_ - 0) / var_348_7)
				var_348_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_6.position).x, (manager.ui.mainCamera.transform.position - var_348_6.position).y, (manager.ui.mainCamera.transform.position - var_348_6.position).z)
				var_348_6.localEulerAngles.z = 0
				var_348_6.localEulerAngles.x = 0
				var_348_6.localEulerAngles = var_348_6.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				var_348_6.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_348_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_6.position).x, (manager.ui.mainCamera.transform.position - var_348_6.position).y, (manager.ui.mainCamera.transform.position - var_348_6.position).z)
				var_348_6.localEulerAngles.z = 0
				var_348_6.localEulerAngles.x = 0
				var_348_6.localEulerAngles = var_348_6.localEulerAngles
			end

			local var_348_8 = 0
			local var_348_9 = 0.8

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_10 = arg_345_1:GetWordFromCfg(421041085)
				local var_348_11 = arg_345_1:FormatText(var_348_10.content)

				arg_345_1.text_.text = var_348_11

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_13 = 32 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 32)

				if (32 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 32)) > 0 and var_348_9 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_8
					end
				end

				arg_345_1.text_.text = var_348_11
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041085", "story_v_out_421041.awb") ~= 0 then
					local var_348_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041085", "story_v_out_421041.awb") / 1000

					if var_348_14 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_14 + var_348_8
					end

					if var_348_10.prefab_name ~= "" and arg_345_1.actors_[var_348_10.prefab_name] ~= nil then
						local var_348_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_10.prefab_name].transform, "story_v_out_421041", "421041085", "story_v_out_421041.awb")

						arg_345_1:RecordAudio("421041085", var_348_15)
						arg_345_1:RecordAudio("421041085", var_348_15)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_421041", "421041085", "story_v_out_421041.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_421041", "421041085", "story_v_out_421041.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_16 = math.max(var_348_9, arg_345_1.talkMaxDuration)

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_16 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_8) / var_348_16

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_8 + var_348_16 and arg_345_1.time_ < var_348_8 + var_348_16 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play421041086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 421041086
		arg_349_1.duration_ = 11.2

		local var_349_0 = {
			zh = 8.1,
			ja = 11.2
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play421041087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10143ui_story = arg_349_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10143ui_story"].transform.position).z)
				arg_349_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10143ui_story"].transform.localEulerAngles = arg_349_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_349_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10143ui_story"].transform.position).z)
				arg_349_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10143ui_story"].transform.localEulerAngles = arg_349_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1047ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1047ui_story = var_352_1.localPosition
			end

			local var_352_2 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 then
				var_352_1.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_2)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 then
				var_352_1.localPosition = Vector3.New(0, 100, 0)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles
			end

			local var_352_3 = arg_349_1.actors_["10143ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_3) and arg_349_1.var_.characterEffect10143ui_story == nil then
				arg_349_1.var_.characterEffect10143ui_story = var_352_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_4 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 and not isNil(var_352_3) then
				if arg_349_1.var_.characterEffect10143ui_story and not isNil(var_352_3) then
					arg_349_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 and not isNil(var_352_3) and arg_349_1.var_.characterEffect10143ui_story then
				arg_349_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_352_6 = arg_349_1.actors_["10145ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_6) and arg_349_1.var_.characterEffect10145ui_story == nil then
				arg_349_1.var_.characterEffect10145ui_story = var_352_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_7 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 and not isNil(var_352_6) then
				if arg_349_1.var_.characterEffect10145ui_story and not isNil(var_352_6) then
					arg_349_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_7)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 and not isNil(var_352_6) and arg_349_1.var_.characterEffect10145ui_story then
				arg_349_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_352_8 = 0
			local var_352_9 = 0.975

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_10 = arg_349_1:GetWordFromCfg(421041086)
				local var_352_11 = arg_349_1:FormatText(var_352_10.content)

				arg_349_1.text_.text = var_352_11

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_13 = 39 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 39)

				if (39 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 39)) > 0 and var_352_9 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_8
					end
				end

				arg_349_1.text_.text = var_352_11
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041086", "story_v_out_421041.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041086", "story_v_out_421041.awb") / 1000

					if var_352_14 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_8
					end

					if var_352_10.prefab_name ~= "" and arg_349_1.actors_[var_352_10.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_10.prefab_name].transform, "story_v_out_421041", "421041086", "story_v_out_421041.awb")

						arg_349_1:RecordAudio("421041086", var_352_15)
						arg_349_1:RecordAudio("421041086", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_421041", "421041086", "story_v_out_421041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_421041", "421041086", "story_v_out_421041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_9, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_16 and arg_349_1.time_ < var_352_8 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play421041087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 421041087
		arg_353_1.duration_ = 19.4

		local var_353_0 = {
			zh = 15.233,
			ja = 19.4
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play421041088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.625

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:GetWordFromCfg(421041087)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 65 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 65)

				if (65 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 65)) > 0 and var_356_0 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041087", "story_v_out_421041.awb") ~= 0 then
					local var_356_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041087", "story_v_out_421041.awb") / 1000

					if var_356_5 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + 0
					end

					if var_356_1.prefab_name ~= "" and arg_353_1.actors_[var_356_1.prefab_name] ~= nil then
						local var_356_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_1.prefab_name].transform, "story_v_out_421041", "421041087", "story_v_out_421041.awb")

						arg_353_1:RecordAudio("421041087", var_356_6)
						arg_353_1:RecordAudio("421041087", var_356_6)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_421041", "421041087", "story_v_out_421041.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_421041", "421041087", "story_v_out_421041.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play421041088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 421041088
		arg_357_1.duration_ = 3.9

		local var_357_0 = {
			zh = 3.9,
			ja = 2.866
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play421041089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10102ui_story = arg_357_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10102ui_story"].transform.position).z)
				arg_357_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["10102ui_story"].transform.localEulerAngles = arg_357_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_357_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10102ui_story"].transform.position).z)
				arg_357_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["10102ui_story"].transform.localEulerAngles = arg_357_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["10145ui_story"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10145ui_story = var_360_1.localPosition
			end

			local var_360_2 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 then
				var_360_1.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_2)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 then
				var_360_1.localPosition = Vector3.New(0, 100, 0)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			local var_360_3 = arg_357_1.actors_["10102ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect10102ui_story == nil then
				arg_357_1.var_.characterEffect10102ui_story = var_360_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_4 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 and not isNil(var_360_3) then
				if arg_357_1.var_.characterEffect10102ui_story and not isNil(var_360_3) then
					arg_357_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect10102ui_story then
				arg_357_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_360_6 = arg_357_1.actors_["10143ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_6) and arg_357_1.var_.characterEffect10143ui_story == nil then
				arg_357_1.var_.characterEffect10143ui_story = var_360_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_7 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 and not isNil(var_360_6) then
				if arg_357_1.var_.characterEffect10143ui_story and not isNil(var_360_6) then
					arg_357_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_7)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 and not isNil(var_360_6) and arg_357_1.var_.characterEffect10143ui_story then
				arg_357_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_360_8 = 0
			local var_360_9 = 0.3

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_10 = arg_357_1:GetWordFromCfg(421041088)
				local var_360_11 = arg_357_1:FormatText(var_360_10.content)

				arg_357_1.text_.text = var_360_11

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 12 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 12)

				if (12 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 12)) > 0 and var_360_9 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_8
					end
				end

				arg_357_1.text_.text = var_360_11
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041088", "story_v_out_421041.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041088", "story_v_out_421041.awb") / 1000

					if var_360_14 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_8
					end

					if var_360_10.prefab_name ~= "" and arg_357_1.actors_[var_360_10.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_10.prefab_name].transform, "story_v_out_421041", "421041088", "story_v_out_421041.awb")

						arg_357_1:RecordAudio("421041088", var_360_15)
						arg_357_1:RecordAudio("421041088", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_421041", "421041088", "story_v_out_421041.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_421041", "421041088", "story_v_out_421041.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_9, arg_357_1.talkMaxDuration)

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_8) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_8 + var_360_16 and arg_357_1.time_ < var_360_8 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play421041089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 421041089
		arg_361_1.duration_ = 7.03

		local var_361_0 = {
			zh = 5.533,
			ja = 7.033
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play421041090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10143ui_story = arg_361_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10143ui_story"].transform.position).z)
				arg_361_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["10143ui_story"].transform.localEulerAngles = arg_361_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_361_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10143ui_story"].transform.position).z)
				arg_361_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["10143ui_story"].transform.localEulerAngles = arg_361_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_364_1 = arg_361_1.actors_["10143ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect10143ui_story == nil then
				arg_361_1.var_.characterEffect10143ui_story = var_364_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 and not isNil(var_364_1) then
				if arg_361_1.var_.characterEffect10143ui_story and not isNil(var_364_1) then
					arg_361_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect10143ui_story then
				arg_361_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_364_4 = arg_361_1.actors_["10102ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_4) and arg_361_1.var_.characterEffect10102ui_story == nil then
				arg_361_1.var_.characterEffect10102ui_story = var_364_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_5 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_5 and not isNil(var_364_4) then
				if arg_361_1.var_.characterEffect10102ui_story and not isNil(var_364_4) then
					arg_361_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_361_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_5)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_5 and arg_361_1.time_ < 0 + var_364_5 + arg_364_0 and not isNil(var_364_4) and arg_361_1.var_.characterEffect10102ui_story then
				arg_361_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_361_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_2")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_364_6 = 0
			local var_364_7 = 0.725

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_8 = arg_361_1:GetWordFromCfg(421041089)
				local var_364_9 = arg_361_1:FormatText(var_364_8.content)

				arg_361_1.text_.text = var_364_9

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_11 = 29 <= 0 and var_364_7 or var_364_7 * (utf8.len(var_364_9) / 29)

				if (29 <= 0 and var_364_7 or var_364_7 * (utf8.len(var_364_9) / 29)) > 0 and var_364_7 < var_364_11 then
					arg_361_1.talkMaxDuration = var_364_11

					if var_364_11 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_11 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_9
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041089", "story_v_out_421041.awb") ~= 0 then
					local var_364_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041089", "story_v_out_421041.awb") / 1000

					if var_364_12 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_12 + var_364_6
					end

					if var_364_8.prefab_name ~= "" and arg_361_1.actors_[var_364_8.prefab_name] ~= nil then
						local var_364_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_8.prefab_name].transform, "story_v_out_421041", "421041089", "story_v_out_421041.awb")

						arg_361_1:RecordAudio("421041089", var_364_13)
						arg_361_1:RecordAudio("421041089", var_364_13)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_421041", "421041089", "story_v_out_421041.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_421041", "421041089", "story_v_out_421041.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_14 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_14 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_14

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_14 and arg_361_1.time_ < var_364_6 + var_364_14 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play421041090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 421041090
		arg_365_1.duration_ = 16.87

		local var_365_0 = {
			zh = 9.633,
			ja = 16.866
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play421041091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.25

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(421041090)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 50 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 50)

				if (50 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 50)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041090", "story_v_out_421041.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041090", "story_v_out_421041.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_421041", "421041090", "story_v_out_421041.awb")

						arg_365_1:RecordAudio("421041090", var_368_6)
						arg_365_1:RecordAudio("421041090", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_421041", "421041090", "story_v_out_421041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_421041", "421041090", "story_v_out_421041.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play421041091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 421041091
		arg_369_1.duration_ = 5.67

		local var_369_0 = {
			zh = 3.8,
			ja = 5.666
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play421041092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10102ui_story = arg_369_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10102ui_story"].transform.position).z)
				arg_369_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["10102ui_story"].transform.localEulerAngles = arg_369_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_369_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10102ui_story"].transform.position).z)
				arg_369_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["10102ui_story"].transform.localEulerAngles = arg_369_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["10102ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect10102ui_story == nil then
				arg_369_1.var_.characterEffect10102ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect10102ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect10102ui_story then
				arg_369_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_372_4 = arg_369_1.actors_["10143ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.characterEffect10143ui_story == nil then
				arg_369_1.var_.characterEffect10143ui_story = var_372_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_5 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_5 and not isNil(var_372_4) then
				if arg_369_1.var_.characterEffect10143ui_story and not isNil(var_372_4) then
					arg_369_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_369_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_5)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_5 and arg_369_1.time_ < 0 + var_372_5 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.characterEffect10143ui_story then
				arg_369_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_369_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_372_6 = 0
			local var_372_7 = 0.525

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_8 = arg_369_1:GetWordFromCfg(421041091)
				local var_372_9 = arg_369_1:FormatText(var_372_8.content)

				arg_369_1.text_.text = var_372_9

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 21 <= 0 and var_372_7 or var_372_7 * (utf8.len(var_372_9) / 21)

				if (21 <= 0 and var_372_7 or var_372_7 * (utf8.len(var_372_9) / 21)) > 0 and var_372_7 < var_372_11 then
					arg_369_1.talkMaxDuration = var_372_11

					if var_372_11 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_9
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041091", "story_v_out_421041.awb") ~= 0 then
					local var_372_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041091", "story_v_out_421041.awb") / 1000

					if var_372_12 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_12 + var_372_6
					end

					if var_372_8.prefab_name ~= "" and arg_369_1.actors_[var_372_8.prefab_name] ~= nil then
						local var_372_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_8.prefab_name].transform, "story_v_out_421041", "421041091", "story_v_out_421041.awb")

						arg_369_1:RecordAudio("421041091", var_372_13)
						arg_369_1:RecordAudio("421041091", var_372_13)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_421041", "421041091", "story_v_out_421041.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_421041", "421041091", "story_v_out_421041.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_14 and arg_369_1.time_ < var_372_6 + var_372_14 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play421041092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 421041092
		arg_373_1.duration_ = 14.9

		local var_373_0 = {
			zh = 10.333,
			ja = 14.9
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play421041093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10143ui_story = arg_373_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10143ui_story"].transform.position).z)
				arg_373_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10143ui_story"].transform.localEulerAngles = arg_373_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_373_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10143ui_story"].transform.position).z)
				arg_373_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10143ui_story"].transform.localEulerAngles = arg_373_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["10143ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10143ui_story == nil then
				arg_373_1.var_.characterEffect10143ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect10143ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10143ui_story then
				arg_373_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_376_4 = arg_373_1.actors_["10102ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect10102ui_story == nil then
				arg_373_1.var_.characterEffect10102ui_story = var_376_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_5 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_5 and not isNil(var_376_4) then
				if arg_373_1.var_.characterEffect10102ui_story and not isNil(var_376_4) then
					arg_373_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_5)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_5 and arg_373_1.time_ < 0 + var_376_5 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect10102ui_story then
				arg_373_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action8_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_376_6 = 0
			local var_376_7 = 1.325

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(421041092)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 53 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 53)

				if (53 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 53)) > 0 and var_376_7 < var_376_11 then
					arg_373_1.talkMaxDuration = var_376_11

					if var_376_11 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_11 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041092", "story_v_out_421041.awb") ~= 0 then
					local var_376_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041092", "story_v_out_421041.awb") / 1000

					if var_376_12 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_6
					end

					if var_376_8.prefab_name ~= "" and arg_373_1.actors_[var_376_8.prefab_name] ~= nil then
						local var_376_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_8.prefab_name].transform, "story_v_out_421041", "421041092", "story_v_out_421041.awb")

						arg_373_1:RecordAudio("421041092", var_376_13)
						arg_373_1:RecordAudio("421041092", var_376_13)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_421041", "421041092", "story_v_out_421041.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_421041", "421041092", "story_v_out_421041.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_14 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_14 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_14

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_14 and arg_373_1.time_ < var_376_6 + var_376_14 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play421041093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 421041093
		arg_377_1.duration_ = 8.7

		local var_377_0 = {
			zh = 6.866,
			ja = 8.7
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play421041094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10143ui_story = arg_377_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["10143ui_story"].transform.position).z)
				arg_377_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["10143ui_story"].transform.localEulerAngles = arg_377_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_377_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["10143ui_story"].transform.position).z)
				arg_377_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["10143ui_story"].transform.localEulerAngles = arg_377_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action8_2")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_380_1 = 0
			local var_380_2 = 0.85

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_3 = arg_377_1:GetWordFromCfg(421041093)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_6 = 34 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_4) / 34)

				if (34 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_4) / 34)) > 0 and var_380_2 < var_380_6 then
					arg_377_1.talkMaxDuration = var_380_6

					if var_380_6 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_6 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041093", "story_v_out_421041.awb") ~= 0 then
					local var_380_7 = manager.audio:GetVoiceLength("story_v_out_421041", "421041093", "story_v_out_421041.awb") / 1000

					if var_380_7 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_1
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_out_421041", "421041093", "story_v_out_421041.awb")

						arg_377_1:RecordAudio("421041093", var_380_8)
						arg_377_1:RecordAudio("421041093", var_380_8)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_421041", "421041093", "story_v_out_421041.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_421041", "421041093", "story_v_out_421041.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_9 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_9 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_9

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_9 and arg_377_1.time_ < var_380_1 + var_380_9 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play421041094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 421041094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play421041095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10102ui_story = arg_381_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10102ui_story"].transform.position).z)
				arg_381_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["10102ui_story"].transform.localEulerAngles = arg_381_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_381_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10102ui_story"].transform.position).z)
				arg_381_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["10102ui_story"].transform.localEulerAngles = arg_381_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["10143ui_story"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10143ui_story = var_384_1.localPosition
			end

			local var_384_2 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 then
				var_384_1.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_2)
				var_384_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_1.position).x, (manager.ui.mainCamera.transform.position - var_384_1.position).y, (manager.ui.mainCamera.transform.position - var_384_1.position).z)
				var_384_1.localEulerAngles.z = 0
				var_384_1.localEulerAngles.x = 0
				var_384_1.localEulerAngles = var_384_1.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 then
				var_384_1.localPosition = Vector3.New(0, 100, 0)
				var_384_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_1.position).x, (manager.ui.mainCamera.transform.position - var_384_1.position).y, (manager.ui.mainCamera.transform.position - var_384_1.position).z)
				var_384_1.localEulerAngles.z = 0
				var_384_1.localEulerAngles.x = 0
				var_384_1.localEulerAngles = var_384_1.localEulerAngles
			end

			if 0.1 < arg_381_1.time_ and arg_381_1.time_ <= 0.1 + arg_384_0 then
				arg_381_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_tea", "")
			end

			local var_384_4 = 0
			local var_384_5 = 1.625

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(421041094).content)

				arg_381_1.text_.text = var_384_6

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_8 = 65 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_6) / 65)

				if (65 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_6) / 65)) > 0 and var_384_5 < var_384_8 then
					arg_381_1.talkMaxDuration = var_384_8

					if var_384_8 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_6
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_9 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_9 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_9

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_9 and arg_381_1.time_ < var_384_4 + var_384_9 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play421041095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 421041095
		arg_385_1.duration_ = 3.8

		local var_385_0 = {
			zh = 2.866,
			ja = 3.8
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play421041096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos10102ui_story = arg_385_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["10102ui_story"].transform.position).z)
				arg_385_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["10102ui_story"].transform.localEulerAngles = arg_385_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_385_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["10102ui_story"].transform.position).z)
				arg_385_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["10102ui_story"].transform.localEulerAngles = arg_385_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["10102ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect10102ui_story == nil then
				arg_385_1.var_.characterEffect10102ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect10102ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect10102ui_story then
				arg_385_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_388_4 = 0
			local var_388_5 = 0.225

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(421041095)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 9 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 9)

				if (9 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 9)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041095", "story_v_out_421041.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041095", "story_v_out_421041.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_out_421041", "421041095", "story_v_out_421041.awb")

						arg_385_1:RecordAudio("421041095", var_388_11)
						arg_385_1:RecordAudio("421041095", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_421041", "421041095", "story_v_out_421041.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_421041", "421041095", "story_v_out_421041.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_12 and arg_385_1.time_ < var_388_4 + var_388_12 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play421041096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 421041096
		arg_389_1.duration_ = 15.13

		local var_389_0 = {
			zh = 10.033,
			ja = 15.133
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play421041097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos10102ui_story = arg_389_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["10102ui_story"].transform.position).z)
				arg_389_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["10102ui_story"].transform.localEulerAngles = arg_389_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["10102ui_story"].transform.position).z)
				arg_389_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["10102ui_story"].transform.localEulerAngles = arg_389_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["10143ui_story"].transform

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos10143ui_story = var_392_1.localPosition
			end

			local var_392_2 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 then
				var_392_1.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_389_1.time_ - 0) / var_392_2)
				var_392_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_1.position).x, (manager.ui.mainCamera.transform.position - var_392_1.position).y, (manager.ui.mainCamera.transform.position - var_392_1.position).z)
				var_392_1.localEulerAngles.z = 0
				var_392_1.localEulerAngles.x = 0
				var_392_1.localEulerAngles = var_392_1.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 then
				var_392_1.localPosition = Vector3.New(0, -1.06, -6)
				var_392_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_1.position).x, (manager.ui.mainCamera.transform.position - var_392_1.position).y, (manager.ui.mainCamera.transform.position - var_392_1.position).z)
				var_392_1.localEulerAngles.z = 0
				var_392_1.localEulerAngles.x = 0
				var_392_1.localEulerAngles = var_392_1.localEulerAngles
			end

			local var_392_3 = arg_389_1.actors_["10143ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_3) and arg_389_1.var_.characterEffect10143ui_story == nil then
				arg_389_1.var_.characterEffect10143ui_story = var_392_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_4 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 and not isNil(var_392_3) then
				if arg_389_1.var_.characterEffect10143ui_story and not isNil(var_392_3) then
					arg_389_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 and not isNil(var_392_3) and arg_389_1.var_.characterEffect10143ui_story then
				arg_389_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_392_6 = arg_389_1.actors_["10102ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_6) and arg_389_1.var_.characterEffect10102ui_story == nil then
				arg_389_1.var_.characterEffect10102ui_story = var_392_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_7 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 and not isNil(var_392_6) then
				if arg_389_1.var_.characterEffect10102ui_story and not isNil(var_392_6) then
					arg_389_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_7)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 and not isNil(var_392_6) and arg_389_1.var_.characterEffect10102ui_story then
				arg_389_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_392_8 = 0
			local var_392_9 = 1.225

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_10 = arg_389_1:GetWordFromCfg(421041096)
				local var_392_11 = arg_389_1:FormatText(var_392_10.content)

				arg_389_1.text_.text = var_392_11

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_13 = 49 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_11) / 49)

				if (49 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_11) / 49)) > 0 and var_392_9 < var_392_13 then
					arg_389_1.talkMaxDuration = var_392_13

					if var_392_13 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_8
					end
				end

				arg_389_1.text_.text = var_392_11
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041096", "story_v_out_421041.awb") ~= 0 then
					local var_392_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041096", "story_v_out_421041.awb") / 1000

					if var_392_14 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_14 + var_392_8
					end

					if var_392_10.prefab_name ~= "" and arg_389_1.actors_[var_392_10.prefab_name] ~= nil then
						local var_392_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_10.prefab_name].transform, "story_v_out_421041", "421041096", "story_v_out_421041.awb")

						arg_389_1:RecordAudio("421041096", var_392_15)
						arg_389_1:RecordAudio("421041096", var_392_15)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_421041", "421041096", "story_v_out_421041.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_421041", "421041096", "story_v_out_421041.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_16 = math.max(var_392_9, arg_389_1.talkMaxDuration)

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_16 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_8) / var_392_16

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_8 + var_392_16 and arg_389_1.time_ < var_392_8 + var_392_16 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play421041097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 421041097
		arg_393_1.duration_ = 19.83

		local var_393_0 = {
			zh = 14.766,
			ja = 19.833
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play421041098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos10143ui_story = arg_393_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["10143ui_story"].transform.position).z)
				arg_393_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["10143ui_story"].transform.localEulerAngles = arg_393_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6)
				arg_393_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["10143ui_story"].transform.position).z)
				arg_393_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["10143ui_story"].transform.localEulerAngles = arg_393_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_396_1 = 0
			local var_396_2 = 1.85

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:GetWordFromCfg(421041097)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_6 = 74 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_4) / 74)

				if (74 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_4) / 74)) > 0 and var_396_2 < var_396_6 then
					arg_393_1.talkMaxDuration = var_396_6

					if var_396_6 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041097", "story_v_out_421041.awb") ~= 0 then
					local var_396_7 = manager.audio:GetVoiceLength("story_v_out_421041", "421041097", "story_v_out_421041.awb") / 1000

					if var_396_7 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_1
					end

					if var_396_3.prefab_name ~= "" and arg_393_1.actors_[var_396_3.prefab_name] ~= nil then
						local var_396_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_3.prefab_name].transform, "story_v_out_421041", "421041097", "story_v_out_421041.awb")

						arg_393_1:RecordAudio("421041097", var_396_8)
						arg_393_1:RecordAudio("421041097", var_396_8)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_421041", "421041097", "story_v_out_421041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_421041", "421041097", "story_v_out_421041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_9 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_9 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_9

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_9 and arg_393_1.time_ < var_396_1 + var_396_9 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play421041098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 421041098
		arg_397_1.duration_ = 2

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play421041099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos10145ui_story = arg_397_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_400_0 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 then
				arg_397_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_397_1.time_ - 0) / var_400_0)
				arg_397_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["10145ui_story"].transform.position).z)
				arg_397_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["10145ui_story"].transform.localEulerAngles = arg_397_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 then
				arg_397_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_397_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["10145ui_story"].transform.position).z)
				arg_397_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["10145ui_story"].transform.localEulerAngles = arg_397_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_400_1 = arg_397_1.actors_["10143ui_story"].transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos10143ui_story = var_400_1.localPosition
			end

			local var_400_2 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 then
				var_400_1.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_397_1.time_ - 0) / var_400_2)
				var_400_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_1.position).x, (manager.ui.mainCamera.transform.position - var_400_1.position).y, (manager.ui.mainCamera.transform.position - var_400_1.position).z)
				var_400_1.localEulerAngles.z = 0
				var_400_1.localEulerAngles.x = 0
				var_400_1.localEulerAngles = var_400_1.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 then
				var_400_1.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_400_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_1.position).x, (manager.ui.mainCamera.transform.position - var_400_1.position).y, (manager.ui.mainCamera.transform.position - var_400_1.position).z)
				var_400_1.localEulerAngles.z = 0
				var_400_1.localEulerAngles.x = 0
				var_400_1.localEulerAngles = var_400_1.localEulerAngles
			end

			local var_400_3 = arg_397_1.actors_["10145ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_3) and arg_397_1.var_.characterEffect10145ui_story == nil then
				arg_397_1.var_.characterEffect10145ui_story = var_400_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_4 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 and not isNil(var_400_3) then
				if arg_397_1.var_.characterEffect10145ui_story and not isNil(var_400_3) then
					arg_397_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 and not isNil(var_400_3) and arg_397_1.var_.characterEffect10145ui_story then
				arg_397_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_400_6 = arg_397_1.actors_["10143ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_6) and arg_397_1.var_.characterEffect10143ui_story == nil then
				arg_397_1.var_.characterEffect10143ui_story = var_400_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_7 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 and not isNil(var_400_6) then
				if arg_397_1.var_.characterEffect10143ui_story and not isNil(var_400_6) then
					arg_397_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_397_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_7)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 and not isNil(var_400_6) and arg_397_1.var_.characterEffect10143ui_story then
				arg_397_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_397_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_400_8 = 0
			local var_400_9 = 0.15

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_10 = arg_397_1:GetWordFromCfg(421041098)
				local var_400_11 = arg_397_1:FormatText(var_400_10.content)

				arg_397_1.text_.text = var_400_11

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_13 = 6 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 6)

				if (6 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 6)) > 0 and var_400_9 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_8
					end
				end

				arg_397_1.text_.text = var_400_11
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041098", "story_v_out_421041.awb") ~= 0 then
					local var_400_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041098", "story_v_out_421041.awb") / 1000

					if var_400_14 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_8
					end

					if var_400_10.prefab_name ~= "" and arg_397_1.actors_[var_400_10.prefab_name] ~= nil then
						local var_400_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_10.prefab_name].transform, "story_v_out_421041", "421041098", "story_v_out_421041.awb")

						arg_397_1:RecordAudio("421041098", var_400_15)
						arg_397_1:RecordAudio("421041098", var_400_15)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_421041", "421041098", "story_v_out_421041.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_421041", "421041098", "story_v_out_421041.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_16 = math.max(var_400_9, arg_397_1.talkMaxDuration)

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_16 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_8) / var_400_16

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_8 + var_400_16 and arg_397_1.time_ < var_400_8 + var_400_16 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play421041099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 421041099
		arg_401_1.duration_ = 12.43

		local var_401_0 = {
			zh = 10,
			ja = 12.433
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play421041100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos10143ui_story = arg_401_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10143ui_story"].transform.position).z)
				arg_401_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["10143ui_story"].transform.localEulerAngles = arg_401_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_401_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["10143ui_story"].transform.position).z)
				arg_401_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["10143ui_story"].transform.localEulerAngles = arg_401_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["10143ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect10143ui_story == nil then
				arg_401_1.var_.characterEffect10143ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect10143ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect10143ui_story then
				arg_401_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_404_4 = arg_401_1.actors_["10145ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.characterEffect10145ui_story == nil then
				arg_401_1.var_.characterEffect10145ui_story = var_404_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_5 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_5 and not isNil(var_404_4) then
				if arg_401_1.var_.characterEffect10145ui_story and not isNil(var_404_4) then
					arg_401_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_401_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_5)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_5 and arg_401_1.time_ < 0 + var_404_5 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.characterEffect10145ui_story then
				arg_401_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_401_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_404_6 = 0
			local var_404_7 = 1.15

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_8 = arg_401_1:GetWordFromCfg(421041099)
				local var_404_9 = arg_401_1:FormatText(var_404_8.content)

				arg_401_1.text_.text = var_404_9

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 46 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 46)

				if (46 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 46)) > 0 and var_404_7 < var_404_11 then
					arg_401_1.talkMaxDuration = var_404_11

					if var_404_11 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_9
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041099", "story_v_out_421041.awb") ~= 0 then
					local var_404_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041099", "story_v_out_421041.awb") / 1000

					if var_404_12 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_12 + var_404_6
					end

					if var_404_8.prefab_name ~= "" and arg_401_1.actors_[var_404_8.prefab_name] ~= nil then
						local var_404_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_8.prefab_name].transform, "story_v_out_421041", "421041099", "story_v_out_421041.awb")

						arg_401_1:RecordAudio("421041099", var_404_13)
						arg_401_1:RecordAudio("421041099", var_404_13)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_421041", "421041099", "story_v_out_421041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_421041", "421041099", "story_v_out_421041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play421041100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 421041100
		arg_405_1.duration_ = 9.3

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play421041101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10145ui_story = arg_405_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10145ui_story"].transform.position).z)
				arg_405_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["10145ui_story"].transform.localEulerAngles = arg_405_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_405_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["10145ui_story"].transform.position).z)
				arg_405_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["10145ui_story"].transform.localEulerAngles = arg_405_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["10145ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect10145ui_story == nil then
				arg_405_1.var_.characterEffect10145ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect10145ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect10145ui_story then
				arg_405_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_408_4 = arg_405_1.actors_["10143ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect10143ui_story == nil then
				arg_405_1.var_.characterEffect10143ui_story = var_408_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_5 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_5 and not isNil(var_408_4) then
				if arg_405_1.var_.characterEffect10143ui_story and not isNil(var_408_4) then
					arg_405_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_405_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_5)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_5 and arg_405_1.time_ < 0 + var_408_5 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect10143ui_story then
				arg_405_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_405_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_2")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_408_6 = 0
			local var_408_7 = 1.025

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_8 = arg_405_1:GetWordFromCfg(421041100)
				local var_408_9 = arg_405_1:FormatText(var_408_8.content)

				arg_405_1.text_.text = var_408_9

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 41 <= 0 and var_408_7 or var_408_7 * (utf8.len(var_408_9) / 41)

				if (41 <= 0 and var_408_7 or var_408_7 * (utf8.len(var_408_9) / 41)) > 0 and var_408_7 < var_408_11 then
					arg_405_1.talkMaxDuration = var_408_11

					if var_408_11 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_11 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_9
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041100", "story_v_out_421041.awb") ~= 0 then
					local var_408_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041100", "story_v_out_421041.awb") / 1000

					if var_408_12 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_12 + var_408_6
					end

					if var_408_8.prefab_name ~= "" and arg_405_1.actors_[var_408_8.prefab_name] ~= nil then
						local var_408_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_8.prefab_name].transform, "story_v_out_421041", "421041100", "story_v_out_421041.awb")

						arg_405_1:RecordAudio("421041100", var_408_13)
						arg_405_1:RecordAudio("421041100", var_408_13)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_421041", "421041100", "story_v_out_421041.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_421041", "421041100", "story_v_out_421041.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play421041101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 421041101
		arg_409_1.duration_ = 5.4

		local var_409_0 = {
			zh = 4.266,
			ja = 5.4
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play421041102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos10143ui_story = arg_409_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).z)
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles = arg_409_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_409_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["10143ui_story"].transform.position).z)
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["10143ui_story"].transform.localEulerAngles = arg_409_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["10143ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect10143ui_story == nil then
				arg_409_1.var_.characterEffect10143ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect10143ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect10143ui_story then
				arg_409_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_412_4 = arg_409_1.actors_["10145ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_4) and arg_409_1.var_.characterEffect10145ui_story == nil then
				arg_409_1.var_.characterEffect10145ui_story = var_412_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_5 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_5 and not isNil(var_412_4) then
				if arg_409_1.var_.characterEffect10145ui_story and not isNil(var_412_4) then
					arg_409_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_5)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_5 and arg_409_1.time_ < 0 + var_412_5 + arg_412_0 and not isNil(var_412_4) and arg_409_1.var_.characterEffect10145ui_story then
				arg_409_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_412_6 = 0
			local var_412_7 = 0.4

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_8 = arg_409_1:GetWordFromCfg(421041101)
				local var_412_9 = arg_409_1:FormatText(var_412_8.content)

				arg_409_1.text_.text = var_412_9

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_11 = 16 <= 0 and var_412_7 or var_412_7 * (utf8.len(var_412_9) / 16)

				if (16 <= 0 and var_412_7 or var_412_7 * (utf8.len(var_412_9) / 16)) > 0 and var_412_7 < var_412_11 then
					arg_409_1.talkMaxDuration = var_412_11

					if var_412_11 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_11 + var_412_6
					end
				end

				arg_409_1.text_.text = var_412_9
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041101", "story_v_out_421041.awb") ~= 0 then
					local var_412_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041101", "story_v_out_421041.awb") / 1000

					if var_412_12 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_12 + var_412_6
					end

					if var_412_8.prefab_name ~= "" and arg_409_1.actors_[var_412_8.prefab_name] ~= nil then
						local var_412_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_8.prefab_name].transform, "story_v_out_421041", "421041101", "story_v_out_421041.awb")

						arg_409_1:RecordAudio("421041101", var_412_13)
						arg_409_1:RecordAudio("421041101", var_412_13)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_421041", "421041101", "story_v_out_421041.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_421041", "421041101", "story_v_out_421041.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_14 = math.max(var_412_7, arg_409_1.talkMaxDuration)

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_14 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_6) / var_412_14

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_6 + var_412_14 and arg_409_1.time_ < var_412_6 + var_412_14 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play421041102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 421041102
		arg_413_1.duration_ = 7.1

		local var_413_0 = {
			zh = 4.833,
			ja = 7.1
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play421041103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos10145ui_story = arg_413_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10145ui_story"].transform.position).z)
				arg_413_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["10145ui_story"].transform.localEulerAngles = arg_413_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_413_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10145ui_story"].transform.position).z)
				arg_413_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["10145ui_story"].transform.localEulerAngles = arg_413_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["10145ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect10145ui_story == nil then
				arg_413_1.var_.characterEffect10145ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect10145ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect10145ui_story then
				arg_413_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_416_4 = arg_413_1.actors_["10143ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_4) and arg_413_1.var_.characterEffect10143ui_story == nil then
				arg_413_1.var_.characterEffect10143ui_story = var_416_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_5 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_5 and not isNil(var_416_4) then
				if arg_413_1.var_.characterEffect10143ui_story and not isNil(var_416_4) then
					arg_413_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_413_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_5)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_5 and arg_413_1.time_ < 0 + var_416_5 + arg_416_0 and not isNil(var_416_4) and arg_413_1.var_.characterEffect10143ui_story then
				arg_413_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_413_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_416_6 = 0
			local var_416_7 = 0.625

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:GetWordFromCfg(421041102)
				local var_416_9 = arg_413_1:FormatText(var_416_8.content)

				arg_413_1.text_.text = var_416_9

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_11 = 25 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_9) / 25)

				if (25 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_9) / 25)) > 0 and var_416_7 < var_416_11 then
					arg_413_1.talkMaxDuration = var_416_11

					if var_416_11 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_11 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_9
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041102", "story_v_out_421041.awb") ~= 0 then
					local var_416_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041102", "story_v_out_421041.awb") / 1000

					if var_416_12 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_6
					end

					if var_416_8.prefab_name ~= "" and arg_413_1.actors_[var_416_8.prefab_name] ~= nil then
						local var_416_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_8.prefab_name].transform, "story_v_out_421041", "421041102", "story_v_out_421041.awb")

						arg_413_1:RecordAudio("421041102", var_416_13)
						arg_413_1:RecordAudio("421041102", var_416_13)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_421041", "421041102", "story_v_out_421041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_421041", "421041102", "story_v_out_421041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_14 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_14 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_14

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_14 and arg_413_1.time_ < var_416_6 + var_416_14 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play421041103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 421041103
		arg_417_1.duration_ = 3.37

		local var_417_0 = {
			zh = 3.233,
			ja = 3.366
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play421041104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos10143ui_story = arg_417_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).z)
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles = arg_417_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_417_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10143ui_story"].transform.position).z)
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10143ui_story"].transform.localEulerAngles = arg_417_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["10143ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10143ui_story == nil then
				arg_417_1.var_.characterEffect10143ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect10143ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10143ui_story then
				arg_417_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_420_4 = arg_417_1.actors_["10145ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect10145ui_story == nil then
				arg_417_1.var_.characterEffect10145ui_story = var_420_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_5 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_5 and not isNil(var_420_4) then
				if arg_417_1.var_.characterEffect10145ui_story and not isNil(var_420_4) then
					arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_5)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_5 and arg_417_1.time_ < 0 + var_420_5 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect10145ui_story then
				arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_420_6 = 0
			local var_420_7 = 0.35

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_8 = arg_417_1:GetWordFromCfg(421041103)
				local var_420_9 = arg_417_1:FormatText(var_420_8.content)

				arg_417_1.text_.text = var_420_9

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 14 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_9) / 14)

				if (14 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_9) / 14)) > 0 and var_420_7 < var_420_11 then
					arg_417_1.talkMaxDuration = var_420_11

					if var_420_11 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_11 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_9
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041103", "story_v_out_421041.awb") ~= 0 then
					local var_420_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041103", "story_v_out_421041.awb") / 1000

					if var_420_12 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_12 + var_420_6
					end

					if var_420_8.prefab_name ~= "" and arg_417_1.actors_[var_420_8.prefab_name] ~= nil then
						local var_420_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_8.prefab_name].transform, "story_v_out_421041", "421041103", "story_v_out_421041.awb")

						arg_417_1:RecordAudio("421041103", var_420_13)
						arg_417_1:RecordAudio("421041103", var_420_13)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_421041", "421041103", "story_v_out_421041.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_421041", "421041103", "story_v_out_421041.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_14 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_14 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_14

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_14 and arg_417_1.time_ < var_420_6 + var_420_14 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play421041104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 421041104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play421041105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["10143ui_story"]) and arg_421_1.var_.characterEffect10143ui_story == nil then
				arg_421_1.var_.characterEffect10143ui_story = arg_421_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["10143ui_story"]) then
				if arg_421_1.var_.characterEffect10143ui_story and not isNil(arg_421_1.actors_["10143ui_story"]) then
					arg_421_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_421_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["10143ui_story"]) and arg_421_1.var_.characterEffect10143ui_story then
				arg_421_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_421_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_424_1 = 0
			local var_424_2 = 0.375

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(421041104).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 15 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 15)

				if (15 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 15)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play421041105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 421041105
		arg_425_1.duration_ = 12.33

		local var_425_0 = {
			zh = 9.3,
			ja = 12.333
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play421041106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos10145ui_story = arg_425_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10145ui_story"].transform.position).z)
				arg_425_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["10145ui_story"].transform.localEulerAngles = arg_425_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_425_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10145ui_story"].transform.position).z)
				arg_425_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["10145ui_story"].transform.localEulerAngles = arg_425_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["10145ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect10145ui_story == nil then
				arg_425_1.var_.characterEffect10145ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect10145ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect10145ui_story then
				arg_425_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_428_4 = 0
			local var_428_5 = 0.975

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_6 = arg_425_1:GetWordFromCfg(421041105)
				local var_428_7 = arg_425_1:FormatText(var_428_6.content)

				arg_425_1.text_.text = var_428_7

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_9 = 39 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 39)

				if (39 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 39)) > 0 and var_428_5 < var_428_9 then
					arg_425_1.talkMaxDuration = var_428_9

					if var_428_9 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_9 + var_428_4
					end
				end

				arg_425_1.text_.text = var_428_7
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041105", "story_v_out_421041.awb") ~= 0 then
					local var_428_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041105", "story_v_out_421041.awb") / 1000

					if var_428_10 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_4
					end

					if var_428_6.prefab_name ~= "" and arg_425_1.actors_[var_428_6.prefab_name] ~= nil then
						local var_428_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_6.prefab_name].transform, "story_v_out_421041", "421041105", "story_v_out_421041.awb")

						arg_425_1:RecordAudio("421041105", var_428_11)
						arg_425_1:RecordAudio("421041105", var_428_11)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_421041", "421041105", "story_v_out_421041.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_421041", "421041105", "story_v_out_421041.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_12 = math.max(var_428_5, arg_425_1.talkMaxDuration)

			if var_428_4 <= arg_425_1.time_ and arg_425_1.time_ < var_428_4 + var_428_12 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_4) / var_428_12

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_4 + var_428_12 and arg_425_1.time_ < var_428_4 + var_428_12 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play421041106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 421041106
		arg_429_1.duration_ = 4.13

		local var_429_0 = {
			zh = 2.966,
			ja = 4.133
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play421041107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10102ui_story = arg_429_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10102ui_story"].transform.position).z)
				arg_429_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["10102ui_story"].transform.localEulerAngles = arg_429_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_429_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10102ui_story"].transform.position).z)
				arg_429_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["10102ui_story"].transform.localEulerAngles = arg_429_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["10143ui_story"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10143ui_story = var_432_1.localPosition
			end

			local var_432_2 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 then
				var_432_1.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_429_1.time_ - 0) / var_432_2)
				var_432_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_1.position).x, (manager.ui.mainCamera.transform.position - var_432_1.position).y, (manager.ui.mainCamera.transform.position - var_432_1.position).z)
				var_432_1.localEulerAngles.z = 0
				var_432_1.localEulerAngles.x = 0
				var_432_1.localEulerAngles = var_432_1.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 then
				var_432_1.localPosition = Vector3.New(0, 100, 0)
				var_432_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_1.position).x, (manager.ui.mainCamera.transform.position - var_432_1.position).y, (manager.ui.mainCamera.transform.position - var_432_1.position).z)
				var_432_1.localEulerAngles.z = 0
				var_432_1.localEulerAngles.x = 0
				var_432_1.localEulerAngles = var_432_1.localEulerAngles
			end

			local var_432_3 = arg_429_1.actors_["10102ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_3) and arg_429_1.var_.characterEffect10102ui_story == nil then
				arg_429_1.var_.characterEffect10102ui_story = var_432_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_4 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 and not isNil(var_432_3) then
				if arg_429_1.var_.characterEffect10102ui_story and not isNil(var_432_3) then
					arg_429_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 and not isNil(var_432_3) and arg_429_1.var_.characterEffect10102ui_story then
				arg_429_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_432_6 = arg_429_1.actors_["10145ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_6) and arg_429_1.var_.characterEffect10145ui_story == nil then
				arg_429_1.var_.characterEffect10145ui_story = var_432_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_7 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 and not isNil(var_432_6) then
				if arg_429_1.var_.characterEffect10145ui_story and not isNil(var_432_6) then
					arg_429_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_429_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_7)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 and not isNil(var_432_6) and arg_429_1.var_.characterEffect10145ui_story then
				arg_429_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_429_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_432_8 = 0
			local var_432_9 = 0.325

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_8 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_10 = arg_429_1:GetWordFromCfg(421041106)
				local var_432_11 = arg_429_1:FormatText(var_432_10.content)

				arg_429_1.text_.text = var_432_11

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_13 = 13 <= 0 and var_432_9 or var_432_9 * (utf8.len(var_432_11) / 13)

				if (13 <= 0 and var_432_9 or var_432_9 * (utf8.len(var_432_11) / 13)) > 0 and var_432_9 < var_432_13 then
					arg_429_1.talkMaxDuration = var_432_13

					if var_432_13 + var_432_8 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_13 + var_432_8
					end
				end

				arg_429_1.text_.text = var_432_11
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041106", "story_v_out_421041.awb") ~= 0 then
					local var_432_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041106", "story_v_out_421041.awb") / 1000

					if var_432_14 + var_432_8 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_14 + var_432_8
					end

					if var_432_10.prefab_name ~= "" and arg_429_1.actors_[var_432_10.prefab_name] ~= nil then
						local var_432_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_10.prefab_name].transform, "story_v_out_421041", "421041106", "story_v_out_421041.awb")

						arg_429_1:RecordAudio("421041106", var_432_15)
						arg_429_1:RecordAudio("421041106", var_432_15)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_421041", "421041106", "story_v_out_421041.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_421041", "421041106", "story_v_out_421041.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_16 = math.max(var_432_9, arg_429_1.talkMaxDuration)

			if var_432_8 <= arg_429_1.time_ and arg_429_1.time_ < var_432_8 + var_432_16 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_8) / var_432_16

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_8 + var_432_16 and arg_429_1.time_ < var_432_8 + var_432_16 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play421041107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 421041107
		arg_433_1.duration_ = 7.97

		local var_433_0 = {
			zh = 5.6,
			ja = 7.966
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play421041108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10145ui_story = arg_433_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10145ui_story"].transform.position).z)
				arg_433_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["10145ui_story"].transform.localEulerAngles = arg_433_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_433_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["10145ui_story"].transform.position).z)
				arg_433_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["10145ui_story"].transform.localEulerAngles = arg_433_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["10145ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect10145ui_story == nil then
				arg_433_1.var_.characterEffect10145ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect10145ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect10145ui_story then
				arg_433_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_436_4 = arg_433_1.actors_["10102ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect10102ui_story == nil then
				arg_433_1.var_.characterEffect10102ui_story = var_436_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_5 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_5 and not isNil(var_436_4) then
				if arg_433_1.var_.characterEffect10102ui_story and not isNil(var_436_4) then
					arg_433_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_433_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_5)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_5 and arg_433_1.time_ < 0 + var_436_5 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect10102ui_story then
				arg_433_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_433_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_436_6 = 0
			local var_436_7 = 0.6

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_8 = arg_433_1:GetWordFromCfg(421041107)
				local var_436_9 = arg_433_1:FormatText(var_436_8.content)

				arg_433_1.text_.text = var_436_9

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 24 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 24)

				if (24 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 24)) > 0 and var_436_7 < var_436_11 then
					arg_433_1.talkMaxDuration = var_436_11

					if var_436_11 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_9
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041107", "story_v_out_421041.awb") ~= 0 then
					local var_436_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041107", "story_v_out_421041.awb") / 1000

					if var_436_12 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_12 + var_436_6
					end

					if var_436_8.prefab_name ~= "" and arg_433_1.actors_[var_436_8.prefab_name] ~= nil then
						local var_436_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_8.prefab_name].transform, "story_v_out_421041", "421041107", "story_v_out_421041.awb")

						arg_433_1:RecordAudio("421041107", var_436_13)
						arg_433_1:RecordAudio("421041107", var_436_13)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_421041", "421041107", "story_v_out_421041.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_421041", "421041107", "story_v_out_421041.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_14 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_14 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_14

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_14 and arg_433_1.time_ < var_436_6 + var_436_14 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play421041108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 421041108
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play421041109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["10145ui_story"]) and arg_437_1.var_.characterEffect10145ui_story == nil then
				arg_437_1.var_.characterEffect10145ui_story = arg_437_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["10145ui_story"]) then
				if arg_437_1.var_.characterEffect10145ui_story and not isNil(arg_437_1.actors_["10145ui_story"]) then
					arg_437_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_437_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["10145ui_story"]) and arg_437_1.var_.characterEffect10145ui_story then
				arg_437_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_437_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 0.925

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(421041108).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 37 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 37)

				if (37 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 37)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play421041109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 421041109
		arg_441_1.duration_ = 14.83

		local var_441_0 = {
			zh = 12.633,
			ja = 14.833
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play421041110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos10145ui_story = arg_441_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["10145ui_story"].transform.position).z)
				arg_441_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["10145ui_story"].transform.localEulerAngles = arg_441_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_441_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["10145ui_story"].transform.position).z)
				arg_441_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["10145ui_story"].transform.localEulerAngles = arg_441_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_444_1 = arg_441_1.actors_["10145ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect10145ui_story == nil then
				arg_441_1.var_.characterEffect10145ui_story = var_444_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_2 and not isNil(var_444_1) then
				if arg_441_1.var_.characterEffect10145ui_story and not isNil(var_444_1) then
					arg_441_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_2 and arg_441_1.time_ < 0 + var_444_2 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect10145ui_story then
				arg_441_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_1")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_444_4 = 0
			local var_444_5 = 1.2

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_6 = arg_441_1:GetWordFromCfg(421041109)
				local var_444_7 = arg_441_1:FormatText(var_444_6.content)

				arg_441_1.text_.text = var_444_7

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_9 = 46 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 46)

				if (46 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 46)) > 0 and var_444_5 < var_444_9 then
					arg_441_1.talkMaxDuration = var_444_9

					if var_444_9 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_4
					end
				end

				arg_441_1.text_.text = var_444_7
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041109", "story_v_out_421041.awb") ~= 0 then
					local var_444_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041109", "story_v_out_421041.awb") / 1000

					if var_444_10 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_4
					end

					if var_444_6.prefab_name ~= "" and arg_441_1.actors_[var_444_6.prefab_name] ~= nil then
						local var_444_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_6.prefab_name].transform, "story_v_out_421041", "421041109", "story_v_out_421041.awb")

						arg_441_1:RecordAudio("421041109", var_444_11)
						arg_441_1:RecordAudio("421041109", var_444_11)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_421041", "421041109", "story_v_out_421041.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_421041", "421041109", "story_v_out_421041.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_12 = math.max(var_444_5, arg_441_1.talkMaxDuration)

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_12 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_4) / var_444_12

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_4 + var_444_12 and arg_441_1.time_ < var_444_4 + var_444_12 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play421041110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 421041110
		arg_445_1.duration_ = 7.53

		local var_445_0 = {
			zh = 5.566,
			ja = 7.533
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play421041111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10143ui_story = arg_445_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10143ui_story"].transform.position).z)
				arg_445_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["10143ui_story"].transform.localEulerAngles = arg_445_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_445_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10143ui_story"].transform.position).z)
				arg_445_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["10143ui_story"].transform.localEulerAngles = arg_445_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_448_1 = arg_445_1.actors_["10102ui_story"].transform

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10102ui_story = var_448_1.localPosition
			end

			local var_448_2 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_2 then
				var_448_1.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_445_1.time_ - 0) / var_448_2)
				var_448_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_448_1.position).x, (manager.ui.mainCamera.transform.position - var_448_1.position).y, (manager.ui.mainCamera.transform.position - var_448_1.position).z)
				var_448_1.localEulerAngles.z = 0
				var_448_1.localEulerAngles.x = 0
				var_448_1.localEulerAngles = var_448_1.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_2 and arg_445_1.time_ < 0 + var_448_2 + arg_448_0 then
				var_448_1.localPosition = Vector3.New(0, 100, 0)
				var_448_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_448_1.position).x, (manager.ui.mainCamera.transform.position - var_448_1.position).y, (manager.ui.mainCamera.transform.position - var_448_1.position).z)
				var_448_1.localEulerAngles.z = 0
				var_448_1.localEulerAngles.x = 0
				var_448_1.localEulerAngles = var_448_1.localEulerAngles
			end

			local var_448_3 = arg_445_1.actors_["10143ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_3) and arg_445_1.var_.characterEffect10143ui_story == nil then
				arg_445_1.var_.characterEffect10143ui_story = var_448_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_4 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 and not isNil(var_448_3) then
				if arg_445_1.var_.characterEffect10143ui_story and not isNil(var_448_3) then
					arg_445_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 and not isNil(var_448_3) and arg_445_1.var_.characterEffect10143ui_story then
				arg_445_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_448_6 = arg_445_1.actors_["10145ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_6) and arg_445_1.var_.characterEffect10145ui_story == nil then
				arg_445_1.var_.characterEffect10145ui_story = var_448_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_7 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 and not isNil(var_448_6) then
				if arg_445_1.var_.characterEffect10145ui_story and not isNil(var_448_6) then
					arg_445_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_445_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_7)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 and not isNil(var_448_6) and arg_445_1.var_.characterEffect10145ui_story then
				arg_445_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_445_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_448_8 = 0
			local var_448_9 = 0.625

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_8 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_10 = arg_445_1:GetWordFromCfg(421041110)
				local var_448_11 = arg_445_1:FormatText(var_448_10.content)

				arg_445_1.text_.text = var_448_11

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_13 = 25 <= 0 and var_448_9 or var_448_9 * (utf8.len(var_448_11) / 25)

				if (25 <= 0 and var_448_9 or var_448_9 * (utf8.len(var_448_11) / 25)) > 0 and var_448_9 < var_448_13 then
					arg_445_1.talkMaxDuration = var_448_13

					if var_448_13 + var_448_8 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_13 + var_448_8
					end
				end

				arg_445_1.text_.text = var_448_11
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041110", "story_v_out_421041.awb") ~= 0 then
					local var_448_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041110", "story_v_out_421041.awb") / 1000

					if var_448_14 + var_448_8 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_14 + var_448_8
					end

					if var_448_10.prefab_name ~= "" and arg_445_1.actors_[var_448_10.prefab_name] ~= nil then
						local var_448_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_10.prefab_name].transform, "story_v_out_421041", "421041110", "story_v_out_421041.awb")

						arg_445_1:RecordAudio("421041110", var_448_15)
						arg_445_1:RecordAudio("421041110", var_448_15)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_421041", "421041110", "story_v_out_421041.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_421041", "421041110", "story_v_out_421041.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_16 = math.max(var_448_9, arg_445_1.talkMaxDuration)

			if var_448_8 <= arg_445_1.time_ and arg_445_1.time_ < var_448_8 + var_448_16 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_8) / var_448_16

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_8 + var_448_16 and arg_445_1.time_ < var_448_8 + var_448_16 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play421041111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 421041111
		arg_449_1.duration_ = 13.47

		local var_449_0 = {
			zh = 10.2,
			ja = 13.466
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play421041112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos10145ui_story = arg_449_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).z)
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles = arg_449_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_449_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["10145ui_story"].transform.position).z)
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["10145ui_story"].transform.localEulerAngles = arg_449_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["10145ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect10145ui_story == nil then
				arg_449_1.var_.characterEffect10145ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect10145ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect10145ui_story then
				arg_449_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_452_4 = arg_449_1.actors_["10143ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_4) and arg_449_1.var_.characterEffect10143ui_story == nil then
				arg_449_1.var_.characterEffect10143ui_story = var_452_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_5 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_5 and not isNil(var_452_4) then
				if arg_449_1.var_.characterEffect10143ui_story and not isNil(var_452_4) then
					arg_449_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_449_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_5)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_5 and arg_449_1.time_ < 0 + var_452_5 + arg_452_0 and not isNil(var_452_4) and arg_449_1.var_.characterEffect10143ui_story then
				arg_449_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_449_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_2")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_452_6 = 0
			local var_452_7 = 1.15

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_8 = arg_449_1:GetWordFromCfg(421041111)
				local var_452_9 = arg_449_1:FormatText(var_452_8.content)

				arg_449_1.text_.text = var_452_9

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_11 = 46 <= 0 and var_452_7 or var_452_7 * (utf8.len(var_452_9) / 46)

				if (46 <= 0 and var_452_7 or var_452_7 * (utf8.len(var_452_9) / 46)) > 0 and var_452_7 < var_452_11 then
					arg_449_1.talkMaxDuration = var_452_11

					if var_452_11 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_11 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_9
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041111", "story_v_out_421041.awb") ~= 0 then
					local var_452_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041111", "story_v_out_421041.awb") / 1000

					if var_452_12 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_12 + var_452_6
					end

					if var_452_8.prefab_name ~= "" and arg_449_1.actors_[var_452_8.prefab_name] ~= nil then
						local var_452_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_8.prefab_name].transform, "story_v_out_421041", "421041111", "story_v_out_421041.awb")

						arg_449_1:RecordAudio("421041111", var_452_13)
						arg_449_1:RecordAudio("421041111", var_452_13)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_421041", "421041111", "story_v_out_421041.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_421041", "421041111", "story_v_out_421041.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_14 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_14 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_14

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_14 and arg_449_1.time_ < var_452_6 + var_452_14 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play421041112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 421041112
		arg_453_1.duration_ = 14.13

		local var_453_0 = {
			zh = 10.3,
			ja = 14.133
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play421041113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1047ui_story = arg_453_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).z)
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles = arg_453_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_453_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).z)
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles = arg_453_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["10145ui_story"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos10145ui_story = var_456_1.localPosition
			end

			local var_456_2 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 then
				var_456_1.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_2)
				var_456_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_1.position).x, (manager.ui.mainCamera.transform.position - var_456_1.position).y, (manager.ui.mainCamera.transform.position - var_456_1.position).z)
				var_456_1.localEulerAngles.z = 0
				var_456_1.localEulerAngles.x = 0
				var_456_1.localEulerAngles = var_456_1.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 then
				var_456_1.localPosition = Vector3.New(0, 100, 0)
				var_456_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_1.position).x, (manager.ui.mainCamera.transform.position - var_456_1.position).y, (manager.ui.mainCamera.transform.position - var_456_1.position).z)
				var_456_1.localEulerAngles.z = 0
				var_456_1.localEulerAngles.x = 0
				var_456_1.localEulerAngles = var_456_1.localEulerAngles
			end

			local var_456_3 = arg_453_1.actors_["10143ui_story"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos10143ui_story = var_456_3.localPosition
			end

			local var_456_4 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				var_456_3.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_4)
				var_456_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_3.position).x, (manager.ui.mainCamera.transform.position - var_456_3.position).y, (manager.ui.mainCamera.transform.position - var_456_3.position).z)
				var_456_3.localEulerAngles.z = 0
				var_456_3.localEulerAngles.x = 0
				var_456_3.localEulerAngles = var_456_3.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				var_456_3.localPosition = Vector3.New(0, 100, 0)
				var_456_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_3.position).x, (manager.ui.mainCamera.transform.position - var_456_3.position).y, (manager.ui.mainCamera.transform.position - var_456_3.position).z)
				var_456_3.localEulerAngles.z = 0
				var_456_3.localEulerAngles.x = 0
				var_456_3.localEulerAngles = var_456_3.localEulerAngles
			end

			local var_456_5 = arg_453_1.actors_["1047ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_5) and arg_453_1.var_.characterEffect1047ui_story == nil then
				arg_453_1.var_.characterEffect1047ui_story = var_456_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_6 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_6 and not isNil(var_456_5) then
				if arg_453_1.var_.characterEffect1047ui_story and not isNil(var_456_5) then
					arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_6 and arg_453_1.time_ < 0 + var_456_6 + arg_456_0 and not isNil(var_456_5) and arg_453_1.var_.characterEffect1047ui_story then
				arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_456_8 = arg_453_1.actors_["10145ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_8) and arg_453_1.var_.characterEffect10145ui_story == nil then
				arg_453_1.var_.characterEffect10145ui_story = var_456_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_9 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_9 and not isNil(var_456_8) then
				if arg_453_1.var_.characterEffect10145ui_story and not isNil(var_456_8) then
					arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_9)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_9 and arg_453_1.time_ < 0 + var_456_9 + arg_456_0 and not isNil(var_456_8) and arg_453_1.var_.characterEffect10145ui_story then
				arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_456_10 = 0
			local var_456_11 = 1.275

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_12 = arg_453_1:GetWordFromCfg(421041112)
				local var_456_13 = arg_453_1:FormatText(var_456_12.content)

				arg_453_1.text_.text = var_456_13

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_15 = 51 <= 0 and var_456_11 or var_456_11 * (utf8.len(var_456_13) / 51)

				if (51 <= 0 and var_456_11 or var_456_11 * (utf8.len(var_456_13) / 51)) > 0 and var_456_11 < var_456_15 then
					arg_453_1.talkMaxDuration = var_456_15

					if var_456_15 + var_456_10 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_15 + var_456_10
					end
				end

				arg_453_1.text_.text = var_456_13
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041112", "story_v_out_421041.awb") ~= 0 then
					local var_456_16 = manager.audio:GetVoiceLength("story_v_out_421041", "421041112", "story_v_out_421041.awb") / 1000

					if var_456_16 + var_456_10 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_16 + var_456_10
					end

					if var_456_12.prefab_name ~= "" and arg_453_1.actors_[var_456_12.prefab_name] ~= nil then
						local var_456_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_12.prefab_name].transform, "story_v_out_421041", "421041112", "story_v_out_421041.awb")

						arg_453_1:RecordAudio("421041112", var_456_17)
						arg_453_1:RecordAudio("421041112", var_456_17)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_421041", "421041112", "story_v_out_421041.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_421041", "421041112", "story_v_out_421041.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_18 = math.max(var_456_11, arg_453_1.talkMaxDuration)

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_18 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_10) / var_456_18

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_10 + var_456_18 and arg_453_1.time_ < var_456_10 + var_456_18 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play421041113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 421041113
		arg_457_1.duration_ = 13.17

		local var_457_0 = {
			zh = 8.933,
			ja = 13.166
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play421041114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1047ui_story = arg_457_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).z)
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles = arg_457_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_457_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).z)
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles = arg_457_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_460_1 = 0
			local var_460_2 = 1.1

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_3 = arg_457_1:GetWordFromCfg(421041113)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_6 = 44 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_4) / 44)

				if (44 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_4) / 44)) > 0 and var_460_2 < var_460_6 then
					arg_457_1.talkMaxDuration = var_460_6

					if var_460_6 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041113", "story_v_out_421041.awb") ~= 0 then
					local var_460_7 = manager.audio:GetVoiceLength("story_v_out_421041", "421041113", "story_v_out_421041.awb") / 1000

					if var_460_7 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_1
					end

					if var_460_3.prefab_name ~= "" and arg_457_1.actors_[var_460_3.prefab_name] ~= nil then
						local var_460_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_3.prefab_name].transform, "story_v_out_421041", "421041113", "story_v_out_421041.awb")

						arg_457_1:RecordAudio("421041113", var_460_8)
						arg_457_1:RecordAudio("421041113", var_460_8)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_421041", "421041113", "story_v_out_421041.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_421041", "421041113", "story_v_out_421041.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_9 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_9 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_9

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_9 and arg_457_1.time_ < var_460_1 + var_460_9 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play421041114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 421041114
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play421041115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1047ui_story = arg_461_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).z)
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles = arg_461_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_461_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).z)
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles = arg_461_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_464_1 = 0
			local var_464_2 = 1.35

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_3 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(421041114).content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 54 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 54)

				if (54 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 54)) > 0 and var_464_2 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_6 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_6 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_6

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_6 and arg_461_1.time_ < var_464_1 + var_464_6 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play421041115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 421041115
		arg_465_1.duration_ = 9.7

		local var_465_0 = {
			zh = 6.7,
			ja = 9.7
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play421041116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos10145ui_story = arg_465_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).z)
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles = arg_465_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_465_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10145ui_story"].transform.position).z)
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["10145ui_story"].transform.localEulerAngles = arg_465_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["10145ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect10145ui_story == nil then
				arg_465_1.var_.characterEffect10145ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect10145ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect10145ui_story then
				arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_468_4 = 0
			local var_468_5 = 0.775

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:GetWordFromCfg(421041115)
				local var_468_7 = arg_465_1:FormatText(var_468_6.content)

				arg_465_1.text_.text = var_468_7

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_9 = 31 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 31)

				if (31 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 31)) > 0 and var_468_5 < var_468_9 then
					arg_465_1.talkMaxDuration = var_468_9

					if var_468_9 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_7
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041115", "story_v_out_421041.awb") ~= 0 then
					local var_468_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041115", "story_v_out_421041.awb") / 1000

					if var_468_10 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_10 + var_468_4
					end

					if var_468_6.prefab_name ~= "" and arg_465_1.actors_[var_468_6.prefab_name] ~= nil then
						local var_468_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_6.prefab_name].transform, "story_v_out_421041", "421041115", "story_v_out_421041.awb")

						arg_465_1:RecordAudio("421041115", var_468_11)
						arg_465_1:RecordAudio("421041115", var_468_11)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_421041", "421041115", "story_v_out_421041.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_421041", "421041115", "story_v_out_421041.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_12 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_12 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_12

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_12 and arg_465_1.time_ < var_468_4 + var_468_12 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play421041116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 421041116
		arg_469_1.duration_ = 9

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play421041117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 2 < arg_469_1.time_ and arg_469_1.time_ <= 2 + arg_472_0 then
				local var_472_0 = arg_469_1.bgs_.ST2401

				arg_469_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_472_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_472_1 = var_472_0:GetComponent("SpriteRenderer")

				if var_472_1 and var_472_1.sprite then
					local var_472_2 = 2 * (var_472_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_472_0.transform.localScale = Vector3.New(var_472_2 / var_472_1.sprite.bounds.size.y < var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x and var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x or var_472_2 / var_472_1.sprite.bounds.size.y, var_472_2 / var_472_1.sprite.bounds.size.y < var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x and var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x or var_472_2 / var_472_1.sprite.bounds.size.y, 0)
				end

				for iter_472_0, iter_472_1 in pairs(arg_469_1.bgs_) do
					if iter_472_0 ~= "ST2401" then
						iter_472_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_472_3 = 4

			if 4 < arg_469_1.time_ and arg_469_1.time_ <= var_472_3 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			if arg_469_1.time_ >= var_472_3 + 0.3 and arg_469_1.time_ < var_472_3 + 0.3 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_4 = 0

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_4 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_5 = 2

			if var_472_4 <= arg_469_1.time_ and arg_469_1.time_ < var_472_4 + var_472_5 then
				local var_472_6 = Color.New(0, 0, 0)

				var_472_6.a = Mathf.Lerp(0, 1, (arg_469_1.time_ - var_472_4) / var_472_5)
				arg_469_1.mask_.color = var_472_6
			end

			if arg_469_1.time_ >= var_472_4 + var_472_5 and arg_469_1.time_ < var_472_4 + var_472_5 + arg_472_0 then
				local var_472_7 = Color.New(0, 0, 0)

				var_472_7.a = 1
				arg_469_1.mask_.color = var_472_7
			end

			local var_472_8 = 2

			if 2 < arg_469_1.time_ and arg_469_1.time_ <= var_472_8 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_9 = 2

			if var_472_8 <= arg_469_1.time_ and arg_469_1.time_ < var_472_8 + var_472_9 then
				local var_472_10 = Color.New(0, 0, 0)

				var_472_10.a = Mathf.Lerp(1, 0, (arg_469_1.time_ - var_472_8) / var_472_9)
				arg_469_1.mask_.color = var_472_10
			end

			if arg_469_1.time_ >= var_472_8 + var_472_9 and arg_469_1.time_ < var_472_8 + var_472_9 + arg_472_0 then
				local var_472_11 = Color.New(0, 0, 0)

				arg_469_1.mask_.enabled = false
				var_472_11.a = 0
				arg_469_1.mask_.color = var_472_11
			end

			local var_472_12 = arg_469_1.actors_["10145ui_story"].transform

			if 1.96599999815226 < arg_469_1.time_ and arg_469_1.time_ <= 1.96599999815226 + arg_472_0 then
				arg_469_1.var_.moveOldPos10145ui_story = var_472_12.localPosition
			end

			local var_472_13 = 0.001

			if 1.96599999815226 <= arg_469_1.time_ and arg_469_1.time_ < 1.96599999815226 + var_472_13 then
				var_472_12.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 1.96599999815226) / var_472_13)
				var_472_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_12.position).x, (manager.ui.mainCamera.transform.position - var_472_12.position).y, (manager.ui.mainCamera.transform.position - var_472_12.position).z)
				var_472_12.localEulerAngles.z = 0
				var_472_12.localEulerAngles.x = 0
				var_472_12.localEulerAngles = var_472_12.localEulerAngles
			end

			if arg_469_1.time_ >= 1.96599999815226 + var_472_13 and arg_469_1.time_ < 1.96599999815226 + var_472_13 + arg_472_0 then
				var_472_12.localPosition = Vector3.New(0, 100, 0)
				var_472_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_12.position).x, (manager.ui.mainCamera.transform.position - var_472_12.position).y, (manager.ui.mainCamera.transform.position - var_472_12.position).z)
				var_472_12.localEulerAngles.z = 0
				var_472_12.localEulerAngles.x = 0
				var_472_12.localEulerAngles = var_472_12.localEulerAngles
			end

			if 0.1 < arg_469_1.time_ and arg_469_1.time_ <= 0.1 + arg_472_0 then
				arg_469_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 1.63333333333333 < arg_469_1.time_ and arg_469_1.time_ <= 1.63333333333333 + arg_472_0 then
				arg_469_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_16 = 4
			local var_472_17 = 1.05

			if 4 < arg_469_1.time_ and arg_469_1.time_ <= var_472_16 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_18 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_18:setOnUpdate(LuaHelper.FloatAction(function(arg_473_0)
					arg_469_1.dialogCg_.alpha = arg_473_0
				end))
				var_472_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_19 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(421041116).content)

				arg_469_1.text_.text = var_472_19

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_21 = 42 <= 0 and var_472_17 or var_472_17 * (utf8.len(var_472_19) / 42)

				if (42 <= 0 and var_472_17 or var_472_17 * (utf8.len(var_472_19) / 42)) > 0 and var_472_17 < var_472_21 then
					arg_469_1.talkMaxDuration = var_472_21
					var_472_16 = var_472_16 + 0.3

					if var_472_21 + var_472_16 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_21 + var_472_16
					end
				end

				arg_469_1.text_.text = var_472_19
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_22 = var_472_16 + 0.3
			local var_472_23 = math.max(var_472_17, arg_469_1.talkMaxDuration)

			if var_472_16 + 0.3 <= arg_469_1.time_ and arg_469_1.time_ < var_472_22 + var_472_23 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_22) / var_472_23

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_22 + var_472_23 and arg_469_1.time_ < var_472_22 + var_472_23 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play421041117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 421041117
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play421041118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.225

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_1 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(421041117).content)

				arg_475_1.text_.text = var_478_1

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_3 = 9 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 9)

				if (9 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 9)) > 0 and var_478_0 < var_478_3 then
					arg_475_1.talkMaxDuration = var_478_3

					if var_478_3 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_3 + 0
					end
				end

				arg_475_1.text_.text = var_478_1
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_4 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_4

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play421041118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 421041118
		arg_479_1.duration_ = 7.5

		local var_479_0 = {
			zh = 5.133,
			ja = 7.5
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play421041119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.925

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_479_1.callingController_:SetSelectedState("calling")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:GetWordFromCfg(421041118)
				local var_482_2 = arg_479_1:FormatText(var_482_1.content)

				arg_479_1.text_.text = var_482_2

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 37 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 37)

				if (37 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 37)) > 0 and var_482_0 < var_482_4 then
					arg_479_1.talkMaxDuration = var_482_4

					if var_482_4 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_4 + 0
					end
				end

				arg_479_1.text_.text = var_482_2
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041118", "story_v_out_421041.awb") ~= 0 then
					local var_482_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041118", "story_v_out_421041.awb") / 1000

					if var_482_5 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + 0
					end

					if var_482_1.prefab_name ~= "" and arg_479_1.actors_[var_482_1.prefab_name] ~= nil then
						local var_482_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_1.prefab_name].transform, "story_v_out_421041", "421041118", "story_v_out_421041.awb")

						arg_479_1:RecordAudio("421041118", var_482_6)
						arg_479_1:RecordAudio("421041118", var_482_6)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_421041", "421041118", "story_v_out_421041.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_421041", "421041118", "story_v_out_421041.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play421041119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 421041119
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play421041120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.525

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(421041119).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 21 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 21)

				if (21 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 21)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play421041120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 421041120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play421041121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.675

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_1 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(421041120).content)

				arg_487_1.text_.text = var_490_1

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_3 = 27 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 27)

				if (27 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 27)) > 0 and var_490_0 < var_490_3 then
					arg_487_1.talkMaxDuration = var_490_3

					if var_490_3 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_3 + 0
					end
				end

				arg_487_1.text_.text = var_490_1
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_4 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_4

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play421041121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 421041121
		arg_491_1.duration_ = 6.83

		local var_491_0 = {
			zh = 4.133,
			ja = 6.833
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play421041122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.625

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_491_1.callingController_:SetSelectedState("calling")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_1 = arg_491_1:GetWordFromCfg(421041121)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 25 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 25)

				if (25 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 25)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041121", "story_v_out_421041.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041121", "story_v_out_421041.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_out_421041", "421041121", "story_v_out_421041.awb")

						arg_491_1:RecordAudio("421041121", var_494_6)
						arg_491_1:RecordAudio("421041121", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_421041", "421041121", "story_v_out_421041.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_421041", "421041121", "story_v_out_421041.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play421041122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 421041122
		arg_495_1.duration_ = 13.27

		local var_495_0 = {
			zh = 8.7,
			ja = 13.266
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play421041123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 1.2

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_495_1.callingController_:SetSelectedState("calling")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:GetWordFromCfg(421041122)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 48 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 48)

				if (48 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 48)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041122", "story_v_out_421041.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041122", "story_v_out_421041.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_421041", "421041122", "story_v_out_421041.awb")

						arg_495_1:RecordAudio("421041122", var_498_6)
						arg_495_1:RecordAudio("421041122", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_421041", "421041122", "story_v_out_421041.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_421041", "421041122", "story_v_out_421041.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play421041123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 421041123
		arg_499_1.duration_ = 11.07

		local var_499_0 = {
			zh = 10.766,
			ja = 11.066
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play421041124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 1.275

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_499_1.callingController_:SetSelectedState("calling")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_1 = arg_499_1:GetWordFromCfg(421041123)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 51 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 51)

				if (51 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 51)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041123", "story_v_out_421041.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041123", "story_v_out_421041.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_out_421041", "421041123", "story_v_out_421041.awb")

						arg_499_1:RecordAudio("421041123", var_502_6)
						arg_499_1:RecordAudio("421041123", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_421041", "421041123", "story_v_out_421041.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_421041", "421041123", "story_v_out_421041.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play421041124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 421041124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play421041125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.225

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_1 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(421041124).content)

				arg_503_1.text_.text = var_506_1

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_3 = 9 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 9)

				if (9 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 9)) > 0 and var_506_0 < var_506_3 then
					arg_503_1.talkMaxDuration = var_506_3

					if var_506_3 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_3 + 0
					end
				end

				arg_503_1.text_.text = var_506_1
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_4 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_4

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play421041125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 421041125
		arg_507_1.duration_ = 20.6

		local var_507_0 = {
			zh = 14.2,
			ja = 20.6
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play421041126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.6

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_507_1.callingController_:SetSelectedState("calling")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_1 = arg_507_1:GetWordFromCfg(421041125)
				local var_510_2 = arg_507_1:FormatText(var_510_1.content)

				arg_507_1.text_.text = var_510_2

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 64 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 64)

				if (64 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 64)) > 0 and var_510_0 < var_510_4 then
					arg_507_1.talkMaxDuration = var_510_4

					if var_510_4 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_4 + 0
					end
				end

				arg_507_1.text_.text = var_510_2
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041125", "story_v_out_421041.awb") ~= 0 then
					local var_510_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041125", "story_v_out_421041.awb") / 1000

					if var_510_5 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + 0
					end

					if var_510_1.prefab_name ~= "" and arg_507_1.actors_[var_510_1.prefab_name] ~= nil then
						local var_510_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_1.prefab_name].transform, "story_v_out_421041", "421041125", "story_v_out_421041.awb")

						arg_507_1:RecordAudio("421041125", var_510_6)
						arg_507_1:RecordAudio("421041125", var_510_6)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_421041", "421041125", "story_v_out_421041.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_421041", "421041125", "story_v_out_421041.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play421041126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 421041126
		arg_511_1.duration_ = 12

		local var_511_0 = {
			zh = 9.433,
			ja = 12
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play421041127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 1.3

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_511_1.callingController_:SetSelectedState("calling")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_1 = arg_511_1:GetWordFromCfg(421041126)
				local var_514_2 = arg_511_1:FormatText(var_514_1.content)

				arg_511_1.text_.text = var_514_2

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_4 = 52 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 52)

				if (52 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 52)) > 0 and var_514_0 < var_514_4 then
					arg_511_1.talkMaxDuration = var_514_4

					if var_514_4 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_4 + 0
					end
				end

				arg_511_1.text_.text = var_514_2
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041126", "story_v_out_421041.awb") ~= 0 then
					local var_514_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041126", "story_v_out_421041.awb") / 1000

					if var_514_5 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + 0
					end

					if var_514_1.prefab_name ~= "" and arg_511_1.actors_[var_514_1.prefab_name] ~= nil then
						local var_514_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_1.prefab_name].transform, "story_v_out_421041", "421041126", "story_v_out_421041.awb")

						arg_511_1:RecordAudio("421041126", var_514_6)
						arg_511_1:RecordAudio("421041126", var_514_6)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_421041", "421041126", "story_v_out_421041.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_421041", "421041126", "story_v_out_421041.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_7 and arg_511_1.time_ < 0 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play421041127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 421041127
		arg_515_1.duration_ = 13.47

		local var_515_0 = {
			zh = 7.8,
			ja = 13.466
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play421041128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 1.1

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_515_1.callingController_:SetSelectedState("calling")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:GetWordFromCfg(421041127)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 44 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 44)

				if (44 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 44)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041127", "story_v_out_421041.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041127", "story_v_out_421041.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_out_421041", "421041127", "story_v_out_421041.awb")

						arg_515_1:RecordAudio("421041127", var_518_6)
						arg_515_1:RecordAudio("421041127", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_421041", "421041127", "story_v_out_421041.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_421041", "421041127", "story_v_out_421041.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play421041128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 421041128
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play421041129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.65

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_1 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(421041128).content)

				arg_519_1.text_.text = var_522_1

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_3 = 26 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 26)

				if (26 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 26)) > 0 and var_522_0 < var_522_3 then
					arg_519_1.talkMaxDuration = var_522_3

					if var_522_3 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_3 + 0
					end
				end

				arg_519_1.text_.text = var_522_1
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_4 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_4

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play421041129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 421041129
		arg_523_1.duration_ = 8.2

		local var_523_0 = {
			zh = 6.3,
			ja = 8.2
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play421041130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.85

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[1302].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_523_1.callingController_:SetSelectedState("calling")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_1 = arg_523_1:GetWordFromCfg(421041129)
				local var_526_2 = arg_523_1:FormatText(var_526_1.content)

				arg_523_1.text_.text = var_526_2

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_4 = 34 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_2) / 34)

				if (34 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_2) / 34)) > 0 and var_526_0 < var_526_4 then
					arg_523_1.talkMaxDuration = var_526_4

					if var_526_4 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_4 + 0
					end
				end

				arg_523_1.text_.text = var_526_2
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041129", "story_v_out_421041.awb") ~= 0 then
					local var_526_5 = manager.audio:GetVoiceLength("story_v_out_421041", "421041129", "story_v_out_421041.awb") / 1000

					if var_526_5 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + 0
					end

					if var_526_1.prefab_name ~= "" and arg_523_1.actors_[var_526_1.prefab_name] ~= nil then
						local var_526_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_1.prefab_name].transform, "story_v_out_421041", "421041129", "story_v_out_421041.awb")

						arg_523_1:RecordAudio("421041129", var_526_6)
						arg_523_1:RecordAudio("421041129", var_526_6)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_421041", "421041129", "story_v_out_421041.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_421041", "421041129", "story_v_out_421041.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_7 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_7 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_7

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_7 and arg_523_1.time_ < 0 + var_526_7 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play421041130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 421041130
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play421041131(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.775

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(421041130).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 31 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 31)

				if (31 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 31)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play421041131 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 421041131
		arg_531_1.duration_ = 8.27

		local var_531_0 = {
			zh = 4.9,
			ja = 8.266
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play421041132(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1047ui_story = arg_531_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_534_0 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				arg_531_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1047ui_story"].transform.position).z)
				arg_531_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1047ui_story"].transform.localEulerAngles = arg_531_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				arg_531_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_531_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1047ui_story"].transform.position).z)
				arg_531_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1047ui_story"].transform.localEulerAngles = arg_531_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_534_1 = arg_531_1.actors_["1047ui_story"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_1) and arg_531_1.var_.characterEffect1047ui_story == nil then
				arg_531_1.var_.characterEffect1047ui_story = var_534_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_2 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_2 and not isNil(var_534_1) then
				if arg_531_1.var_.characterEffect1047ui_story and not isNil(var_534_1) then
					arg_531_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_2 and arg_531_1.time_ < 0 + var_534_2 + arg_534_0 and not isNil(var_534_1) and arg_531_1.var_.characterEffect1047ui_story then
				arg_531_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_534_4 = 0
			local var_534_5 = 0.525

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_4 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_6 = arg_531_1:GetWordFromCfg(421041131)
				local var_534_7 = arg_531_1:FormatText(var_534_6.content)

				arg_531_1.text_.text = var_534_7

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_9 = 21 <= 0 and var_534_5 or var_534_5 * (utf8.len(var_534_7) / 21)

				if (21 <= 0 and var_534_5 or var_534_5 * (utf8.len(var_534_7) / 21)) > 0 and var_534_5 < var_534_9 then
					arg_531_1.talkMaxDuration = var_534_9

					if var_534_9 + var_534_4 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_9 + var_534_4
					end
				end

				arg_531_1.text_.text = var_534_7
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041131", "story_v_out_421041.awb") ~= 0 then
					local var_534_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041131", "story_v_out_421041.awb") / 1000

					if var_534_10 + var_534_4 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_10 + var_534_4
					end

					if var_534_6.prefab_name ~= "" and arg_531_1.actors_[var_534_6.prefab_name] ~= nil then
						local var_534_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_6.prefab_name].transform, "story_v_out_421041", "421041131", "story_v_out_421041.awb")

						arg_531_1:RecordAudio("421041131", var_534_11)
						arg_531_1:RecordAudio("421041131", var_534_11)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_421041", "421041131", "story_v_out_421041.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_421041", "421041131", "story_v_out_421041.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_12 = math.max(var_534_5, arg_531_1.talkMaxDuration)

			if var_534_4 <= arg_531_1.time_ and arg_531_1.time_ < var_534_4 + var_534_12 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_4) / var_534_12

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_4 + var_534_12 and arg_531_1.time_ < var_534_4 + var_534_12 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play421041132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 421041132
		arg_535_1.duration_ = 5.77

		local var_535_0 = {
			zh = 2.5,
			ja = 5.766
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play421041133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos10143ui_story = arg_535_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_538_0 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 then
				arg_535_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_535_1.time_ - 0) / var_538_0)
				arg_535_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10143ui_story"].transform.position).z)
				arg_535_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["10143ui_story"].transform.localEulerAngles = arg_535_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 then
				arg_535_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_535_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10143ui_story"].transform.position).z)
				arg_535_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["10143ui_story"].transform.localEulerAngles = arg_535_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_538_1 = arg_535_1.actors_["10143ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_1) and arg_535_1.var_.characterEffect10143ui_story == nil then
				arg_535_1.var_.characterEffect10143ui_story = var_538_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_2 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_2 and not isNil(var_538_1) then
				if arg_535_1.var_.characterEffect10143ui_story and not isNil(var_538_1) then
					arg_535_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_2 and arg_535_1.time_ < 0 + var_538_2 + arg_538_0 and not isNil(var_538_1) and arg_535_1.var_.characterEffect10143ui_story then
				arg_535_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_538_4 = arg_535_1.actors_["1047ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_4) and arg_535_1.var_.characterEffect1047ui_story == nil then
				arg_535_1.var_.characterEffect1047ui_story = var_538_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_5 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_5 and not isNil(var_538_4) then
				if arg_535_1.var_.characterEffect1047ui_story and not isNil(var_538_4) then
					arg_535_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_5)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_5 and arg_535_1.time_ < 0 + var_538_5 + arg_538_0 and not isNil(var_538_4) and arg_535_1.var_.characterEffect1047ui_story then
				arg_535_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_538_6 = 0
			local var_538_7 = 0.325

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_6 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_8 = arg_535_1:GetWordFromCfg(421041132)
				local var_538_9 = arg_535_1:FormatText(var_538_8.content)

				arg_535_1.text_.text = var_538_9

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_11 = 13 <= 0 and var_538_7 or var_538_7 * (utf8.len(var_538_9) / 13)

				if (13 <= 0 and var_538_7 or var_538_7 * (utf8.len(var_538_9) / 13)) > 0 and var_538_7 < var_538_11 then
					arg_535_1.talkMaxDuration = var_538_11

					if var_538_11 + var_538_6 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_11 + var_538_6
					end
				end

				arg_535_1.text_.text = var_538_9
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041132", "story_v_out_421041.awb") ~= 0 then
					local var_538_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041132", "story_v_out_421041.awb") / 1000

					if var_538_12 + var_538_6 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_12 + var_538_6
					end

					if var_538_8.prefab_name ~= "" and arg_535_1.actors_[var_538_8.prefab_name] ~= nil then
						local var_538_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_8.prefab_name].transform, "story_v_out_421041", "421041132", "story_v_out_421041.awb")

						arg_535_1:RecordAudio("421041132", var_538_13)
						arg_535_1:RecordAudio("421041132", var_538_13)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_421041", "421041132", "story_v_out_421041.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_421041", "421041132", "story_v_out_421041.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_14 = math.max(var_538_7, arg_535_1.talkMaxDuration)

			if var_538_6 <= arg_535_1.time_ and arg_535_1.time_ < var_538_6 + var_538_14 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_6) / var_538_14

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_6 + var_538_14 and arg_535_1.time_ < var_538_6 + var_538_14 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play421041133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 421041133
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play421041134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["10143ui_story"]) and arg_539_1.var_.characterEffect10143ui_story == nil then
				arg_539_1.var_.characterEffect10143ui_story = arg_539_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["10143ui_story"]) then
				if arg_539_1.var_.characterEffect10143ui_story and not isNil(arg_539_1.actors_["10143ui_story"]) then
					arg_539_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_539_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_0)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["10143ui_story"]) and arg_539_1.var_.characterEffect10143ui_story then
				arg_539_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_539_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_542_1 = 0
			local var_542_2 = 0.475

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(421041133).content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 19 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 19)

				if (19 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 19)) > 0 and var_542_2 < var_542_5 then
					arg_539_1.talkMaxDuration = var_542_5

					if var_542_5 + var_542_1 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + var_542_1
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_6 = math.max(var_542_2, arg_539_1.talkMaxDuration)

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_6 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_1) / var_542_6

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_1 + var_542_6 and arg_539_1.time_ < var_542_1 + var_542_6 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play421041134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 421041134
		arg_543_1.duration_ = 15.97

		local var_543_0 = {
			zh = 13.9,
			ja = 15.966
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play421041135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.var_.moveOldPos1047ui_story = arg_543_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_546_0 = 0.001

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 then
				arg_543_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_543_1.time_ - 0) / var_546_0)
				arg_543_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1047ui_story"].transform.position).z)
				arg_543_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["1047ui_story"].transform.localEulerAngles = arg_543_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 then
				arg_543_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_543_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1047ui_story"].transform.position).z)
				arg_543_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["1047ui_story"].transform.localEulerAngles = arg_543_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_546_1 = arg_543_1.actors_["10143ui_story"].transform

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.var_.moveOldPos10143ui_story = var_546_1.localPosition
			end

			local var_546_2 = 0.001

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_2 then
				var_546_1.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_543_1.time_ - 0) / var_546_2)
				var_546_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_1.position).x, (manager.ui.mainCamera.transform.position - var_546_1.position).y, (manager.ui.mainCamera.transform.position - var_546_1.position).z)
				var_546_1.localEulerAngles.z = 0
				var_546_1.localEulerAngles.x = 0
				var_546_1.localEulerAngles = var_546_1.localEulerAngles
			end

			if arg_543_1.time_ >= 0 + var_546_2 and arg_543_1.time_ < 0 + var_546_2 + arg_546_0 then
				var_546_1.localPosition = Vector3.New(0, 100, 0)
				var_546_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_1.position).x, (manager.ui.mainCamera.transform.position - var_546_1.position).y, (manager.ui.mainCamera.transform.position - var_546_1.position).z)
				var_546_1.localEulerAngles.z = 0
				var_546_1.localEulerAngles.x = 0
				var_546_1.localEulerAngles = var_546_1.localEulerAngles
			end

			local var_546_3 = arg_543_1.actors_["1047ui_story"]

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(var_546_3) and arg_543_1.var_.characterEffect1047ui_story == nil then
				arg_543_1.var_.characterEffect1047ui_story = var_546_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_4 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 and not isNil(var_546_3) then
				if arg_543_1.var_.characterEffect1047ui_story and not isNil(var_546_3) then
					arg_543_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 and not isNil(var_546_3) and arg_543_1.var_.characterEffect1047ui_story then
				arg_543_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_546_6 = 0
			local var_546_7 = 1.55

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_6 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_8 = arg_543_1:GetWordFromCfg(421041134)
				local var_546_9 = arg_543_1:FormatText(var_546_8.content)

				arg_543_1.text_.text = var_546_9

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_11 = 62 <= 0 and var_546_7 or var_546_7 * (utf8.len(var_546_9) / 62)

				if (62 <= 0 and var_546_7 or var_546_7 * (utf8.len(var_546_9) / 62)) > 0 and var_546_7 < var_546_11 then
					arg_543_1.talkMaxDuration = var_546_11

					if var_546_11 + var_546_6 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_11 + var_546_6
					end
				end

				arg_543_1.text_.text = var_546_9
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041134", "story_v_out_421041.awb") ~= 0 then
					local var_546_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041134", "story_v_out_421041.awb") / 1000

					if var_546_12 + var_546_6 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_12 + var_546_6
					end

					if var_546_8.prefab_name ~= "" and arg_543_1.actors_[var_546_8.prefab_name] ~= nil then
						local var_546_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_8.prefab_name].transform, "story_v_out_421041", "421041134", "story_v_out_421041.awb")

						arg_543_1:RecordAudio("421041134", var_546_13)
						arg_543_1:RecordAudio("421041134", var_546_13)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_421041", "421041134", "story_v_out_421041.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_421041", "421041134", "story_v_out_421041.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_14 = math.max(var_546_7, arg_543_1.talkMaxDuration)

			if var_546_6 <= arg_543_1.time_ and arg_543_1.time_ < var_546_6 + var_546_14 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_6) / var_546_14

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_6 + var_546_14 and arg_543_1.time_ < var_546_6 + var_546_14 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play421041135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 421041135
		arg_547_1.duration_ = 5.87

		local var_547_0 = {
			zh = 4.9,
			ja = 5.866
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play421041136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.var_.moveOldPos1047ui_story = arg_547_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_550_0 = 0.001

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 then
				arg_547_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_547_1.time_ - 0) / var_550_0)
				arg_547_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_547_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["1047ui_story"].transform.position).z)
				arg_547_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_547_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_547_1.actors_["1047ui_story"].transform.localEulerAngles = arg_547_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 then
				arg_547_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_547_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_547_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["1047ui_story"].transform.position).z)
				arg_547_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_547_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_547_1.actors_["1047ui_story"].transform.localEulerAngles = arg_547_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_550_1 = 0
			local var_550_2 = 0.575

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_3 = arg_547_1:GetWordFromCfg(421041135)
				local var_550_4 = arg_547_1:FormatText(var_550_3.content)

				arg_547_1.text_.text = var_550_4

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_6 = 23 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_4) / 23)

				if (23 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_4) / 23)) > 0 and var_550_2 < var_550_6 then
					arg_547_1.talkMaxDuration = var_550_6

					if var_550_6 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_6 + var_550_1
					end
				end

				arg_547_1.text_.text = var_550_4
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041135", "story_v_out_421041.awb") ~= 0 then
					local var_550_7 = manager.audio:GetVoiceLength("story_v_out_421041", "421041135", "story_v_out_421041.awb") / 1000

					if var_550_7 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_7 + var_550_1
					end

					if var_550_3.prefab_name ~= "" and arg_547_1.actors_[var_550_3.prefab_name] ~= nil then
						local var_550_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_3.prefab_name].transform, "story_v_out_421041", "421041135", "story_v_out_421041.awb")

						arg_547_1:RecordAudio("421041135", var_550_8)
						arg_547_1:RecordAudio("421041135", var_550_8)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_421041", "421041135", "story_v_out_421041.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_421041", "421041135", "story_v_out_421041.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_9 = math.max(var_550_2, arg_547_1.talkMaxDuration)

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_9 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_1) / var_550_9

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_1 + var_550_9 and arg_547_1.time_ < var_550_1 + var_550_9 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play421041136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 421041136
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play421041137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.var_.moveOldPos1047ui_story = arg_551_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_554_0 = 0.001

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 then
				arg_551_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_551_1.time_ - 0) / var_554_0)
				arg_551_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_551_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1047ui_story"].transform.position).z)
				arg_551_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_551_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_551_1.actors_["1047ui_story"].transform.localEulerAngles = arg_551_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 then
				arg_551_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_551_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_551_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1047ui_story"].transform.position).z)
				arg_551_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_551_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_551_1.actors_["1047ui_story"].transform.localEulerAngles = arg_551_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_554_1 = 0
			local var_554_2 = 0.65

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_3 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(421041136).content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 26 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 26)

				if (26 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 26)) > 0 and var_554_2 < var_554_5 then
					arg_551_1.talkMaxDuration = var_554_5

					if var_554_5 + var_554_1 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + var_554_1
					end
				end

				arg_551_1.text_.text = var_554_3
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_6 = math.max(var_554_2, arg_551_1.talkMaxDuration)

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_6 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_1) / var_554_6

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_1 + var_554_6 and arg_551_1.time_ < var_554_1 + var_554_6 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play421041137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 421041137
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play421041138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 1.275

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(421041137).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 51 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 51)

				if (51 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 51)) > 0 and var_558_0 < var_558_3 then
					arg_555_1.talkMaxDuration = var_558_3

					if var_558_3 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_3 + 0
					end
				end

				arg_555_1.text_.text = var_558_1
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_4 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_4 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_4

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_4 and arg_555_1.time_ < 0 + var_558_4 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play421041138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 421041138
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play421041139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 1.4

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(421041138).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 56 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 56)

				if (56 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 56)) > 0 and var_562_0 < var_562_3 then
					arg_559_1.talkMaxDuration = var_562_3

					if var_562_3 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_3 + 0
					end
				end

				arg_559_1.text_.text = var_562_1
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_4 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_4 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_4

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_4 and arg_559_1.time_ < 0 + var_562_4 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play421041139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 421041139
		arg_563_1.duration_ = 7.17

		local var_563_0 = {
			zh = 6.666,
			ja = 7.166
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play421041140(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.var_.moveOldPos1047ui_story = arg_563_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_566_0 = 0.001

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 then
				arg_563_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_563_1.time_ - 0) / var_566_0)
				arg_563_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_563_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["1047ui_story"].transform.position).z)
				arg_563_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_563_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_563_1.actors_["1047ui_story"].transform.localEulerAngles = arg_563_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 then
				arg_563_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_563_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_563_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_563_1.actors_["1047ui_story"].transform.position).z)
				arg_563_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_563_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_563_1.actors_["1047ui_story"].transform.localEulerAngles = arg_563_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_566_1 = arg_563_1.actors_["1047ui_story"]

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(var_566_1) and arg_563_1.var_.characterEffect1047ui_story == nil then
				arg_563_1.var_.characterEffect1047ui_story = var_566_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_2 and not isNil(var_566_1) then
				if arg_563_1.var_.characterEffect1047ui_story and not isNil(var_566_1) then
					arg_563_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= 0 + var_566_2 and arg_563_1.time_ < 0 + var_566_2 + arg_566_0 and not isNil(var_566_1) and arg_563_1.var_.characterEffect1047ui_story then
				arg_563_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_566_4 = 0
			local var_566_5 = 0.725

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_4 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_6 = arg_563_1:GetWordFromCfg(421041139)
				local var_566_7 = arg_563_1:FormatText(var_566_6.content)

				arg_563_1.text_.text = var_566_7

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_9 = 29 <= 0 and var_566_5 or var_566_5 * (utf8.len(var_566_7) / 29)

				if (29 <= 0 and var_566_5 or var_566_5 * (utf8.len(var_566_7) / 29)) > 0 and var_566_5 < var_566_9 then
					arg_563_1.talkMaxDuration = var_566_9

					if var_566_9 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_9 + var_566_4
					end
				end

				arg_563_1.text_.text = var_566_7
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041139", "story_v_out_421041.awb") ~= 0 then
					local var_566_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041139", "story_v_out_421041.awb") / 1000

					if var_566_10 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_10 + var_566_4
					end

					if var_566_6.prefab_name ~= "" and arg_563_1.actors_[var_566_6.prefab_name] ~= nil then
						local var_566_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_6.prefab_name].transform, "story_v_out_421041", "421041139", "story_v_out_421041.awb")

						arg_563_1:RecordAudio("421041139", var_566_11)
						arg_563_1:RecordAudio("421041139", var_566_11)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_421041", "421041139", "story_v_out_421041.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_421041", "421041139", "story_v_out_421041.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_12 = math.max(var_566_5, arg_563_1.talkMaxDuration)

			if var_566_4 <= arg_563_1.time_ and arg_563_1.time_ < var_566_4 + var_566_12 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_4) / var_566_12

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_4 + var_566_12 and arg_563_1.time_ < var_566_4 + var_566_12 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_563_1:InitPlayNodeList()
	end,
	Play421041140 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 421041140
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play421041141(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1047ui_story"]) and arg_567_1.var_.characterEffect1047ui_story == nil then
				arg_567_1.var_.characterEffect1047ui_story = arg_567_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1047ui_story"]) then
				if arg_567_1.var_.characterEffect1047ui_story and not isNil(arg_567_1.actors_["1047ui_story"]) then
					arg_567_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_567_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_567_1.time_ - 0) / var_570_0)
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1047ui_story"]) and arg_567_1.var_.characterEffect1047ui_story then
				arg_567_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_567_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_570_1 = 0
			local var_570_2 = 0.275

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(421041140).content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 11 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 11)

				if (11 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 11)) > 0 and var_570_2 < var_570_5 then
					arg_567_1.talkMaxDuration = var_570_5

					if var_570_5 + var_570_1 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + var_570_1
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_6 = math.max(var_570_2, arg_567_1.talkMaxDuration)

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_6 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_1) / var_570_6

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_1 + var_570_6 and arg_567_1.time_ < var_570_1 + var_570_6 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play421041141 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 421041141
		arg_571_1.duration_ = 2.23

		local var_571_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play421041142(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.var_.moveOldPos10102ui_story = arg_571_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_574_0 = 0.001

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 then
				arg_571_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_571_1.time_ - 0) / var_574_0)
				arg_571_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["10102ui_story"].transform.position).z)
				arg_571_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["10102ui_story"].transform.localEulerAngles = arg_571_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 then
				arg_571_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_571_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["10102ui_story"].transform.position).z)
				arg_571_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["10102ui_story"].transform.localEulerAngles = arg_571_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_574_1 = arg_571_1.actors_["1047ui_story"].transform

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.var_.moveOldPos1047ui_story = var_574_1.localPosition
			end

			local var_574_2 = 0.001

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_2 then
				var_574_1.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_571_1.time_ - 0) / var_574_2)
				var_574_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_574_1.position).x, (manager.ui.mainCamera.transform.position - var_574_1.position).y, (manager.ui.mainCamera.transform.position - var_574_1.position).z)
				var_574_1.localEulerAngles.z = 0
				var_574_1.localEulerAngles.x = 0
				var_574_1.localEulerAngles = var_574_1.localEulerAngles
			end

			if arg_571_1.time_ >= 0 + var_574_2 and arg_571_1.time_ < 0 + var_574_2 + arg_574_0 then
				var_574_1.localPosition = Vector3.New(0, 100, 0)
				var_574_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_574_1.position).x, (manager.ui.mainCamera.transform.position - var_574_1.position).y, (manager.ui.mainCamera.transform.position - var_574_1.position).z)
				var_574_1.localEulerAngles.z = 0
				var_574_1.localEulerAngles.x = 0
				var_574_1.localEulerAngles = var_574_1.localEulerAngles
			end

			local var_574_3 = arg_571_1.actors_["10102ui_story"]

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(var_574_3) and arg_571_1.var_.characterEffect10102ui_story == nil then
				arg_571_1.var_.characterEffect10102ui_story = var_574_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_4 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_4 and not isNil(var_574_3) then
				if arg_571_1.var_.characterEffect10102ui_story and not isNil(var_574_3) then
					arg_571_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_4 and arg_571_1.time_ < 0 + var_574_4 + arg_574_0 and not isNil(var_574_3) and arg_571_1.var_.characterEffect10102ui_story then
				arg_571_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_574_6 = 0
			local var_574_7 = 0.2

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_6 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_8 = arg_571_1:GetWordFromCfg(421041141)
				local var_574_9 = arg_571_1:FormatText(var_574_8.content)

				arg_571_1.text_.text = var_574_9

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_11 = 8 <= 0 and var_574_7 or var_574_7 * (utf8.len(var_574_9) / 8)

				if (8 <= 0 and var_574_7 or var_574_7 * (utf8.len(var_574_9) / 8)) > 0 and var_574_7 < var_574_11 then
					arg_571_1.talkMaxDuration = var_574_11

					if var_574_11 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_11 + var_574_6
					end
				end

				arg_571_1.text_.text = var_574_9
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041141", "story_v_out_421041.awb") ~= 0 then
					local var_574_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041141", "story_v_out_421041.awb") / 1000

					if var_574_12 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_12 + var_574_6
					end

					if var_574_8.prefab_name ~= "" and arg_571_1.actors_[var_574_8.prefab_name] ~= nil then
						local var_574_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_8.prefab_name].transform, "story_v_out_421041", "421041141", "story_v_out_421041.awb")

						arg_571_1:RecordAudio("421041141", var_574_13)
						arg_571_1:RecordAudio("421041141", var_574_13)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_421041", "421041141", "story_v_out_421041.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_421041", "421041141", "story_v_out_421041.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_14 = math.max(var_574_7, arg_571_1.talkMaxDuration)

			if var_574_6 <= arg_571_1.time_ and arg_571_1.time_ < var_574_6 + var_574_14 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_6) / var_574_14

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_6 + var_574_14 and arg_571_1.time_ < var_574_6 + var_574_14 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play421041142 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 421041142
		arg_575_1.duration_ = 8.57

		local var_575_0 = {
			zh = 4.833,
			ja = 8.566
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play421041143(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos10145ui_story = arg_575_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_578_0 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				arg_575_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10145ui_story"].transform.position).z)
				arg_575_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["10145ui_story"].transform.localEulerAngles = arg_575_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				arg_575_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_575_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["10145ui_story"].transform.position).z)
				arg_575_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["10145ui_story"].transform.localEulerAngles = arg_575_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_578_1 = arg_575_1.actors_["10145ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect10145ui_story == nil then
				arg_575_1.var_.characterEffect10145ui_story = var_578_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_2 and not isNil(var_578_1) then
				if arg_575_1.var_.characterEffect10145ui_story and not isNil(var_578_1) then
					arg_575_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= 0 + var_578_2 and arg_575_1.time_ < 0 + var_578_2 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect10145ui_story then
				arg_575_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_578_4 = arg_575_1.actors_["10102ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_4) and arg_575_1.var_.characterEffect10102ui_story == nil then
				arg_575_1.var_.characterEffect10102ui_story = var_578_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_5 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_5 and not isNil(var_578_4) then
				if arg_575_1.var_.characterEffect10102ui_story and not isNil(var_578_4) then
					arg_575_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_575_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_575_1.time_ - 0) / var_578_5)
				end
			end

			if arg_575_1.time_ >= 0 + var_578_5 and arg_575_1.time_ < 0 + var_578_5 + arg_578_0 and not isNil(var_578_4) and arg_575_1.var_.characterEffect10102ui_story then
				arg_575_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_575_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_578_6 = 0
			local var_578_7 = 0.575

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_6 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_8 = arg_575_1:GetWordFromCfg(421041142)
				local var_578_9 = arg_575_1:FormatText(var_578_8.content)

				arg_575_1.text_.text = var_578_9

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_11 = 23 <= 0 and var_578_7 or var_578_7 * (utf8.len(var_578_9) / 23)

				if (23 <= 0 and var_578_7 or var_578_7 * (utf8.len(var_578_9) / 23)) > 0 and var_578_7 < var_578_11 then
					arg_575_1.talkMaxDuration = var_578_11

					if var_578_11 + var_578_6 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_11 + var_578_6
					end
				end

				arg_575_1.text_.text = var_578_9
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041142", "story_v_out_421041.awb") ~= 0 then
					local var_578_12 = manager.audio:GetVoiceLength("story_v_out_421041", "421041142", "story_v_out_421041.awb") / 1000

					if var_578_12 + var_578_6 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_12 + var_578_6
					end

					if var_578_8.prefab_name ~= "" and arg_575_1.actors_[var_578_8.prefab_name] ~= nil then
						local var_578_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_8.prefab_name].transform, "story_v_out_421041", "421041142", "story_v_out_421041.awb")

						arg_575_1:RecordAudio("421041142", var_578_13)
						arg_575_1:RecordAudio("421041142", var_578_13)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_421041", "421041142", "story_v_out_421041.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_421041", "421041142", "story_v_out_421041.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_14 = math.max(var_578_7, arg_575_1.talkMaxDuration)

			if var_578_6 <= arg_575_1.time_ and arg_575_1.time_ < var_578_6 + var_578_14 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_6) / var_578_14

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_6 + var_578_14 and arg_575_1.time_ < var_578_6 + var_578_14 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play421041143 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 421041143
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play421041144(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["10145ui_story"]) and arg_579_1.var_.characterEffect10145ui_story == nil then
				arg_579_1.var_.characterEffect10145ui_story = arg_579_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["10145ui_story"]) then
				if arg_579_1.var_.characterEffect10145ui_story and not isNil(arg_579_1.actors_["10145ui_story"]) then
					arg_579_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_579_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_579_1.time_ - 0) / var_582_0)
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["10145ui_story"]) and arg_579_1.var_.characterEffect10145ui_story then
				arg_579_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_579_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_582_1 = 0
			local var_582_2 = 0.75

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_3 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(421041143).content)

				arg_579_1.text_.text = var_582_3

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 30 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_3) / 30)

				if (30 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_3) / 30)) > 0 and var_582_2 < var_582_5 then
					arg_579_1.talkMaxDuration = var_582_5

					if var_582_5 + var_582_1 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + var_582_1
					end
				end

				arg_579_1.text_.text = var_582_3
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_6 = math.max(var_582_2, arg_579_1.talkMaxDuration)

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_6 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_1) / var_582_6

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_1 + var_582_6 and arg_579_1.time_ < var_582_1 + var_582_6 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play421041144 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 421041144
		arg_583_1.duration_ = 5.1

		local var_583_0 = {
			zh = 3.133,
			ja = 5.1
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play421041145(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.var_.moveOldPos10102ui_story = arg_583_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_586_0 = 0.001

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 then
				arg_583_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_583_1.time_ - 0) / var_586_0)
				arg_583_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_583_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["10102ui_story"].transform.position).z)
				arg_583_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_583_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_583_1.actors_["10102ui_story"].transform.localEulerAngles = arg_583_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 then
				arg_583_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_583_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_583_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["10102ui_story"].transform.position).z)
				arg_583_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_583_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_583_1.actors_["10102ui_story"].transform.localEulerAngles = arg_583_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_586_1 = arg_583_1.actors_["10102ui_story"]

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(var_586_1) and arg_583_1.var_.characterEffect10102ui_story == nil then
				arg_583_1.var_.characterEffect10102ui_story = var_586_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_2 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_2 and not isNil(var_586_1) then
				if arg_583_1.var_.characterEffect10102ui_story and not isNil(var_586_1) then
					arg_583_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= 0 + var_586_2 and arg_583_1.time_ < 0 + var_586_2 + arg_586_0 and not isNil(var_586_1) and arg_583_1.var_.characterEffect10102ui_story then
				arg_583_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_586_4 = 0
			local var_586_5 = 0.325

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_4 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_6 = arg_583_1:GetWordFromCfg(421041144)
				local var_586_7 = arg_583_1:FormatText(var_586_6.content)

				arg_583_1.text_.text = var_586_7

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_9 = 13 <= 0 and var_586_5 or var_586_5 * (utf8.len(var_586_7) / 13)

				if (13 <= 0 and var_586_5 or var_586_5 * (utf8.len(var_586_7) / 13)) > 0 and var_586_5 < var_586_9 then
					arg_583_1.talkMaxDuration = var_586_9

					if var_586_9 + var_586_4 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_9 + var_586_4
					end
				end

				arg_583_1.text_.text = var_586_7
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041144", "story_v_out_421041.awb") ~= 0 then
					local var_586_10 = manager.audio:GetVoiceLength("story_v_out_421041", "421041144", "story_v_out_421041.awb") / 1000

					if var_586_10 + var_586_4 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_10 + var_586_4
					end

					if var_586_6.prefab_name ~= "" and arg_583_1.actors_[var_586_6.prefab_name] ~= nil then
						local var_586_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_6.prefab_name].transform, "story_v_out_421041", "421041144", "story_v_out_421041.awb")

						arg_583_1:RecordAudio("421041144", var_586_11)
						arg_583_1:RecordAudio("421041144", var_586_11)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_421041", "421041144", "story_v_out_421041.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_421041", "421041144", "story_v_out_421041.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_12 = math.max(var_586_5, arg_583_1.talkMaxDuration)

			if var_586_4 <= arg_583_1.time_ and arg_583_1.time_ < var_586_4 + var_586_12 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_4) / var_586_12

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_4 + var_586_12 and arg_583_1.time_ < var_586_4 + var_586_12 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play421041145 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 421041145
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
			arg_587_1.auto_ = false
		end

		function arg_587_1.playNext_(arg_589_0)
			arg_587_1.onStoryFinished_()
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos10102ui_story = arg_587_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_590_0 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 then
				arg_587_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_587_1.time_ - 0) / var_590_0)
				arg_587_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).z)
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles = arg_587_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 then
				arg_587_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_587_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).z)
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles = arg_587_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_590_1 = arg_587_1.actors_["10145ui_story"].transform

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos10145ui_story = var_590_1.localPosition
			end

			local var_590_2 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_2 then
				var_590_1.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_587_1.time_ - 0) / var_590_2)
				var_590_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_590_1.position).x, (manager.ui.mainCamera.transform.position - var_590_1.position).y, (manager.ui.mainCamera.transform.position - var_590_1.position).z)
				var_590_1.localEulerAngles.z = 0
				var_590_1.localEulerAngles.x = 0
				var_590_1.localEulerAngles = var_590_1.localEulerAngles
			end

			if arg_587_1.time_ >= 0 + var_590_2 and arg_587_1.time_ < 0 + var_590_2 + arg_590_0 then
				var_590_1.localPosition = Vector3.New(0, 100, 0)
				var_590_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_590_1.position).x, (manager.ui.mainCamera.transform.position - var_590_1.position).y, (manager.ui.mainCamera.transform.position - var_590_1.position).z)
				var_590_1.localEulerAngles.z = 0
				var_590_1.localEulerAngles.x = 0
				var_590_1.localEulerAngles = var_590_1.localEulerAngles
			end

			if 0.499999999999 < arg_587_1.time_ and arg_587_1.time_ <= 0.499999999999 + arg_590_0 then
				arg_587_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_brake", "")
			end

			local var_590_4 = 0
			local var_590_5 = 1.5

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_4 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_6 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(421041145).content)

				arg_587_1.text_.text = var_590_6

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_8 = 60 <= 0 and var_590_5 or var_590_5 * (utf8.len(var_590_6) / 60)

				if (60 <= 0 and var_590_5 or var_590_5 * (utf8.len(var_590_6) / 60)) > 0 and var_590_5 < var_590_8 then
					arg_587_1.talkMaxDuration = var_590_8

					if var_590_8 + var_590_4 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_8 + var_590_4
					end
				end

				arg_587_1.text_.text = var_590_6
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_9 = math.max(var_590_5, arg_587_1.talkMaxDuration)

			if var_590_4 <= arg_587_1.time_ and arg_587_1.time_ < var_590_4 + var_590_9 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_4) / var_590_9

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_4 + var_590_9 and arg_587_1.time_ < var_590_4 + var_590_9 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D12a",
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/ST0110"
	},
	voices = {
		"story_v_out_421041.awb"
	}
}
