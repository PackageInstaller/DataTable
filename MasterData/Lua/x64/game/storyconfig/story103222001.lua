return {
	Play322201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322201001
		arg_1_1.duration_ = 7.47

		local var_1_0 = {
			zh = 6.400000333332,
			ja = 7.46600033333333
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
				arg_1_0:Play322201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 4.43400033518208 < arg_1_1.time_ and arg_1_1.time_ <= 4.43400033518208 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 4.43400033518208 + 0.140999998151256 and arg_1_1.time_ < 4.43400033518208 + 0.140999998151256 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09f")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501088).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501089).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_0 + 1.999999999999 and arg_1_1.time_ < var_4_0 + 1.999999999999 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_1 = 2.00000033333333

			if 2.00000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_1 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_2 = 1.2

			if var_4_1 <= arg_1_1.time_ and arg_1_1.time_ < var_4_1 + var_4_2 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_1) / var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_1 + var_4_2 and arg_1_1.time_ < var_4_1 + var_4_2 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)

				var_4_4.a = 1
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_5 = 3.20000033333333

			if 3.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "L09f"

			if arg_1_1.bgs_.L09f == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.L09f

				arg_1_1.bgs_.L09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_14 = "1043ui_story"

			if arg_1_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_4_15 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_1_1.stage_.transform)

				var_4_15.name = var_4_14
				var_4_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_14] = var_4_15

				local var_4_16 = var_4_15:GetComponentInChildren(typeof(CharacterEffect))

				var_4_16.enabled = true

				local var_4_17 = GameObjectTools.GetOrAddComponent(var_4_15, typeof(DynamicBoneHelper))

				if var_4_17 then
					var_4_17:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_16.transform, false)

				arg_1_1.var_[var_4_14 .. "Animator"] = var_4_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_14 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_14 .. "LipSync"] = var_4_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_18 = arg_1_1.actors_["1043ui_story"].transform

			if 4.40000033333333 < arg_1_1.time_ and arg_1_1.time_ <= 4.40000033333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1043ui_story = var_4_18.localPosition
			end

			local var_4_19 = 0.001

			if 4.40000033333333 <= arg_1_1.time_ and arg_1_1.time_ < 4.40000033333333 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_1_1.time_ - 4.40000033333333) / var_4_19)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 4.40000033333333 + var_4_19 and arg_1_1.time_ < 4.40000033333333 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			local var_4_20 = arg_1_1.actors_["1043ui_story"]

			if 4.40000033333333 < arg_1_1.time_ and arg_1_1.time_ <= 4.40000033333333 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.characterEffect1043ui_story == nil then
				arg_1_1.var_.characterEffect1043ui_story = var_4_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_21 = 0.200000002980232

			if 4.40000033333333 <= arg_1_1.time_ and arg_1_1.time_ < 4.40000033333333 + var_4_21 and not isNil(var_4_20) then
				if arg_1_1.var_.characterEffect1043ui_story and not isNil(var_4_20) then
					arg_1_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 4.40000033333333 + var_4_21 and arg_1_1.time_ < 4.40000033333333 + var_4_21 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.characterEffect1043ui_story then
				arg_1_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 4.40000033333333 < arg_1_1.time_ and arg_1_1.time_ <= 4.40000033333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 4.40000033333333 < arg_1_1.time_ and arg_1_1.time_ <= 4.40000033333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 2.8 < arg_1_1.time_ and arg_1_1.time_ <= 2.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			if 4.1 < arg_1_1.time_ and arg_1_1.time_ <= 4.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_sword", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			if 2.8 < arg_1_1.time_ and arg_1_1.time_ <= 2.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_4_30 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			if 2.81 < arg_1_1.time_ and arg_1_1.time_ <= 2.81 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "init_story", "bgm_activity_4_5_story_source.awb")

				local var_4_33 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "init_story")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 4.40000033333333
			local var_4_35 = 0.175

			if 4.40000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
					arg_1_1.dialogCg_.alpha = arg_9_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(322201001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 7 <= 0 and var_4_35 or var_4_35 * (utf8.len(var_4_38) / 7)

				if (7 <= 0 and var_4_35 or var_4_35 * (utf8.len(var_4_38) / 7)) > 0 and var_4_35 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_34 = var_4_34 + 0.3

					if var_4_40 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201001", "story_v_out_322201.awb") ~= 0 then
					local var_4_41 = manager.audio:GetVoiceLength("story_v_out_322201", "322201001", "story_v_out_322201.awb") / 1000

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_322201", "322201001", "story_v_out_322201.awb")

						arg_1_1:RecordAudio("322201001", var_4_42)
						arg_1_1:RecordAudio("322201001", var_4_42)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322201", "322201001", "story_v_out_322201.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322201", "322201001", "story_v_out_322201.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_34 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.40000033333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322201002 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 322201002
		arg_11_1.duration_ = 2.7

		local var_11_0 = {
			zh = 2.433,
			ja = 2.7
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play322201003(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1043ui_story = arg_11_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1043ui_story"].transform.position).z)
				arg_11_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1043ui_story"].transform.localEulerAngles = arg_11_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1043ui_story"].transform.position).z)
				arg_11_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1043ui_story"].transform.localEulerAngles = arg_11_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_14_1 = "1111ui_story"

			if arg_11_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_14_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_11_1.stage_.transform)

				var_14_2.name = var_14_1
				var_14_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_[var_14_1] = var_14_2

				local var_14_3 = var_14_2:GetComponentInChildren(typeof(CharacterEffect))

				var_14_3.enabled = true

				local var_14_4 = GameObjectTools.GetOrAddComponent(var_14_2, typeof(DynamicBoneHelper))

				if var_14_4 then
					var_14_4:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_3.transform, false)

				arg_11_1.var_[var_14_1 .. "Animator"] = var_14_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_[var_14_1 .. "Animator"].applyRootMotion = true
				arg_11_1.var_[var_14_1 .. "LipSync"] = var_14_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_5 = arg_11_1.actors_["1111ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1111ui_story = var_14_5.localPosition
			end

			local var_14_6 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 then
				var_14_5.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_11_1.time_ - 0) / var_14_6)
				var_14_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_5.position).x, (manager.ui.mainCamera.transform.position - var_14_5.position).y, (manager.ui.mainCamera.transform.position - var_14_5.position).z)
				var_14_5.localEulerAngles.z = 0
				var_14_5.localEulerAngles.x = 0
				var_14_5.localEulerAngles = var_14_5.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 then
				var_14_5.localPosition = Vector3.New(0, -0.87, -5.7)
				var_14_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_5.position).x, (manager.ui.mainCamera.transform.position - var_14_5.position).y, (manager.ui.mainCamera.transform.position - var_14_5.position).z)
				var_14_5.localEulerAngles.z = 0
				var_14_5.localEulerAngles.x = 0
				var_14_5.localEulerAngles = var_14_5.localEulerAngles
			end

			local var_14_7 = arg_11_1.actors_["1111ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_7) and arg_11_1.var_.characterEffect1111ui_story == nil then
				arg_11_1.var_.characterEffect1111ui_story = var_14_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_8 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_8 and not isNil(var_14_7) then
				if arg_11_1.var_.characterEffect1111ui_story and not isNil(var_14_7) then
					arg_11_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_8 and arg_11_1.time_ < 0 + var_14_8 + arg_14_0 and not isNil(var_14_7) and arg_11_1.var_.characterEffect1111ui_story then
				arg_11_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_14_10 = arg_11_1.actors_["1043ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_10) and arg_11_1.var_.characterEffect1043ui_story == nil then
				arg_11_1.var_.characterEffect1043ui_story = var_14_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_11 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_11 and not isNil(var_14_10) then
				if arg_11_1.var_.characterEffect1043ui_story and not isNil(var_14_10) then
					arg_11_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_11)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_11 and arg_11_1.time_ < 0 + var_14_11 + arg_14_0 and not isNil(var_14_10) and arg_11_1.var_.characterEffect1043ui_story then
				arg_11_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_11_1.time_ and arg_11_1.time_ <= 0.1 + arg_14_0 then
				arg_11_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlightbroken", "")
			end

			local var_14_13 = 0
			local var_14_14 = 0.225

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_13 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_15 = arg_11_1:GetWordFromCfg(322201002)
				local var_14_16 = arg_11_1:FormatText(var_14_15.content)

				arg_11_1.text_.text = var_14_16

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_18 = 9 <= 0 and var_14_14 or var_14_14 * (utf8.len(var_14_16) / 9)

				if (9 <= 0 and var_14_14 or var_14_14 * (utf8.len(var_14_16) / 9)) > 0 and var_14_14 < var_14_18 then
					arg_11_1.talkMaxDuration = var_14_18

					if var_14_18 + var_14_13 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_18 + var_14_13
					end
				end

				arg_11_1.text_.text = var_14_16
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201002", "story_v_out_322201.awb") ~= 0 then
					local var_14_19 = manager.audio:GetVoiceLength("story_v_out_322201", "322201002", "story_v_out_322201.awb") / 1000

					if var_14_19 + var_14_13 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_19 + var_14_13
					end

					if var_14_15.prefab_name ~= "" and arg_11_1.actors_[var_14_15.prefab_name] ~= nil then
						local var_14_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_15.prefab_name].transform, "story_v_out_322201", "322201002", "story_v_out_322201.awb")

						arg_11_1:RecordAudio("322201002", var_14_20)
						arg_11_1:RecordAudio("322201002", var_14_20)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_322201", "322201002", "story_v_out_322201.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_322201", "322201002", "story_v_out_322201.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_21 = math.max(var_14_14, arg_11_1.talkMaxDuration)

			if var_14_13 <= arg_11_1.time_ and arg_11_1.time_ < var_14_13 + var_14_21 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_13) / var_14_21

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_13 + var_14_21 and arg_11_1.time_ < var_14_13 + var_14_21 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play322201003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 322201003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play322201004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1111ui_story = arg_15_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).z)
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles = arg_15_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).z)
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles = arg_15_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_15_1.time_ and arg_15_1.time_ <= 0.1 + arg_18_0 then
				arg_15_1:AudioAction("play", "effect", "se_story_144", "se_story_144_drop", "")
			end

			local var_18_2 = 0
			local var_18_3 = 1.8

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_2 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_4 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(322201003).content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_6 = 72 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 72)

				if (72 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 72)) > 0 and var_18_3 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_2
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_3, arg_15_1.talkMaxDuration)

			if var_18_2 <= arg_15_1.time_ and arg_15_1.time_ < var_18_2 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_2) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_2 + var_18_7 and arg_15_1.time_ < var_18_2 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play322201004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 322201004
		arg_19_1.duration_ = 9.2

		local var_19_0 = {
			zh = 6.933,
			ja = 9.2
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play322201005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1111ui_story = arg_19_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1111ui_story"].transform.position).z)
				arg_19_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1111ui_story"].transform.localEulerAngles = arg_19_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_19_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1111ui_story"].transform.position).z)
				arg_19_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1111ui_story"].transform.localEulerAngles = arg_19_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1111ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1111ui_story == nil then
				arg_19_1.var_.characterEffect1111ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect1111ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1111ui_story then
				arg_19_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_22_4 = 0
			local var_22_5 = 0.775

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_6 = arg_19_1:GetWordFromCfg(322201004)
				local var_22_7 = arg_19_1:FormatText(var_22_6.content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_9 = 31 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 31)

				if (31 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 31)) > 0 and var_22_5 < var_22_9 then
					arg_19_1.talkMaxDuration = var_22_9

					if var_22_9 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_4
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201004", "story_v_out_322201.awb") ~= 0 then
					local var_22_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201004", "story_v_out_322201.awb") / 1000

					if var_22_10 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_4
					end

					if var_22_6.prefab_name ~= "" and arg_19_1.actors_[var_22_6.prefab_name] ~= nil then
						local var_22_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_6.prefab_name].transform, "story_v_out_322201", "322201004", "story_v_out_322201.awb")

						arg_19_1:RecordAudio("322201004", var_22_11)
						arg_19_1:RecordAudio("322201004", var_22_11)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_322201", "322201004", "story_v_out_322201.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_322201", "322201004", "story_v_out_322201.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_12 = math.max(var_22_5, arg_19_1.talkMaxDuration)

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_12 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_4) / var_22_12

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_4 + var_22_12 and arg_19_1.time_ < var_22_4 + var_22_12 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play322201005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 322201005
		arg_23_1.duration_ = 5.03

		local var_23_0 = {
			zh = 3.6,
			ja = 5.033
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play322201006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1111ui_story = arg_23_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1111ui_story"].transform.position).z)
				arg_23_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1111ui_story"].transform.localEulerAngles = arg_23_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_23_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1111ui_story"].transform.position).z)
				arg_23_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1111ui_story"].transform.localEulerAngles = arg_23_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1043ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1043ui_story = var_26_1.localPosition
			end

			local var_26_2 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				var_26_1.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_23_1.time_ - 0) / var_26_2)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			local var_26_3 = arg_23_1.actors_["1043ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect1043ui_story == nil then
				arg_23_1.var_.characterEffect1043ui_story = var_26_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_4 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 and not isNil(var_26_3) then
				if arg_23_1.var_.characterEffect1043ui_story and not isNil(var_26_3) then
					arg_23_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect1043ui_story then
				arg_23_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_26_6 = arg_23_1.actors_["1111ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1111ui_story == nil then
				arg_23_1.var_.characterEffect1111ui_story = var_26_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_7 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 and not isNil(var_26_6) then
				if arg_23_1.var_.characterEffect1111ui_story and not isNil(var_26_6) then
					arg_23_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_7)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1111ui_story then
				arg_23_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_26_8 = 0
			local var_26_9 = 0.45

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(322201005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 18 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 18)

				if (18 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 18)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201005", "story_v_out_322201.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_322201", "322201005", "story_v_out_322201.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_322201", "322201005", "story_v_out_322201.awb")

						arg_23_1:RecordAudio("322201005", var_26_15)
						arg_23_1:RecordAudio("322201005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322201", "322201005", "story_v_out_322201.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322201", "322201005", "story_v_out_322201.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play322201006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 322201006
		arg_27_1.duration_ = 5.27

		local var_27_0 = {
			zh = 5.133,
			ja = 5.266
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play322201007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_30_0 = 0
			local var_30_1 = 0.625

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_2 = arg_27_1:GetWordFromCfg(322201006)
				local var_30_3 = arg_27_1:FormatText(var_30_2.content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 25 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 25)

				if (25 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 25)) > 0 and var_30_1 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201006", "story_v_out_322201.awb") ~= 0 then
					local var_30_6 = manager.audio:GetVoiceLength("story_v_out_322201", "322201006", "story_v_out_322201.awb") / 1000

					if var_30_6 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_0
					end

					if var_30_2.prefab_name ~= "" and arg_27_1.actors_[var_30_2.prefab_name] ~= nil then
						local var_30_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_2.prefab_name].transform, "story_v_out_322201", "322201006", "story_v_out_322201.awb")

						arg_27_1:RecordAudio("322201006", var_30_7)
						arg_27_1:RecordAudio("322201006", var_30_7)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322201", "322201006", "story_v_out_322201.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322201", "322201006", "story_v_out_322201.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play322201007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322201007
		arg_31_1.duration_ = 7

		local var_31_0 = {
			zh = 5.866,
			ja = 7
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play322201008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1111ui_story"]) and arg_31_1.var_.characterEffect1111ui_story == nil then
				arg_31_1.var_.characterEffect1111ui_story = arg_31_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1111ui_story"]) then
				if arg_31_1.var_.characterEffect1111ui_story and not isNil(arg_31_1.actors_["1111ui_story"]) then
					arg_31_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1111ui_story"]) and arg_31_1.var_.characterEffect1111ui_story then
				arg_31_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_34_2 = arg_31_1.actors_["1043ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1043ui_story == nil then
				arg_31_1.var_.characterEffect1043ui_story = var_34_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_3 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.characterEffect1043ui_story and not isNil(var_34_2) then
					arg_31_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_3)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1043ui_story then
				arg_31_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_34_4 = 0
			local var_34_5 = 0.525

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(322201007)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 21 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 21)

				if (21 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 21)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201007", "story_v_out_322201.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201007", "story_v_out_322201.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_322201", "322201007", "story_v_out_322201.awb")

						arg_31_1:RecordAudio("322201007", var_34_11)
						arg_31_1:RecordAudio("322201007", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322201", "322201007", "story_v_out_322201.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322201", "322201007", "story_v_out_322201.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play322201008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 322201008
		arg_35_1.duration_ = 3.7

		local var_35_0 = {
			zh = 3.566,
			ja = 3.7
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play322201009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1043ui_story"]) and arg_35_1.var_.characterEffect1043ui_story == nil then
				arg_35_1.var_.characterEffect1043ui_story = arg_35_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1043ui_story"]) then
				if arg_35_1.var_.characterEffect1043ui_story and not isNil(arg_35_1.actors_["1043ui_story"]) then
					arg_35_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1043ui_story"]) and arg_35_1.var_.characterEffect1043ui_story then
				arg_35_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_38_2 = arg_35_1.actors_["1111ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1111ui_story == nil then
				arg_35_1.var_.characterEffect1111ui_story = var_38_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_3 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.characterEffect1111ui_story and not isNil(var_38_2) then
					arg_35_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_3)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1111ui_story then
				arg_35_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043actionlink/1043action442")
			end

			local var_38_4 = 0
			local var_38_5 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(322201008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 16 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 16)

				if (16 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 16)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201008", "story_v_out_322201.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201008", "story_v_out_322201.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_322201", "322201008", "story_v_out_322201.awb")

						arg_35_1:RecordAudio("322201008", var_38_11)
						arg_35_1:RecordAudio("322201008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_322201", "322201008", "story_v_out_322201.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_322201", "322201008", "story_v_out_322201.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play322201009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322201009
		arg_39_1.duration_ = 4.7

		local var_39_0 = {
			zh = 3.233,
			ja = 4.7
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play322201010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			local var_42_0 = 0
			local var_42_1 = 0.4

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(322201009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 16 <= 0 and var_42_1 or var_42_1 * (utf8.len(var_42_3) / 16)

				if (16 <= 0 and var_42_1 or var_42_1 * (utf8.len(var_42_3) / 16)) > 0 and var_42_1 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201009", "story_v_out_322201.awb") ~= 0 then
					local var_42_6 = manager.audio:GetVoiceLength("story_v_out_322201", "322201009", "story_v_out_322201.awb") / 1000

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end

					if var_42_2.prefab_name ~= "" and arg_39_1.actors_[var_42_2.prefab_name] ~= nil then
						local var_42_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_2.prefab_name].transform, "story_v_out_322201", "322201009", "story_v_out_322201.awb")

						arg_39_1:RecordAudio("322201009", var_42_7)
						arg_39_1:RecordAudio("322201009", var_42_7)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_322201", "322201009", "story_v_out_322201.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_322201", "322201009", "story_v_out_322201.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_8 and arg_39_1.time_ < var_42_0 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play322201010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 322201010
		arg_43_1.duration_ = 3.1

		local var_43_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play322201011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1111ui_story"]) and arg_43_1.var_.characterEffect1111ui_story == nil then
				arg_43_1.var_.characterEffect1111ui_story = arg_43_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1111ui_story"]) then
				if arg_43_1.var_.characterEffect1111ui_story and not isNil(arg_43_1.actors_["1111ui_story"]) then
					arg_43_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1111ui_story"]) and arg_43_1.var_.characterEffect1111ui_story then
				arg_43_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_46_2 = arg_43_1.actors_["1043ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1043ui_story == nil then
				arg_43_1.var_.characterEffect1043ui_story = var_46_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_3 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.characterEffect1043ui_story and not isNil(var_46_2) then
					arg_43_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_3)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1043ui_story then
				arg_43_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action429")
			end

			local var_46_4 = 0
			local var_46_5 = 0.15

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(322201010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 6 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 6)

				if (6 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 6)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201010", "story_v_out_322201.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201010", "story_v_out_322201.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_322201", "322201010", "story_v_out_322201.awb")

						arg_43_1:RecordAudio("322201010", var_46_11)
						arg_43_1:RecordAudio("322201010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_322201", "322201010", "story_v_out_322201.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_322201", "322201010", "story_v_out_322201.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play322201011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 322201011
		arg_47_1.duration_ = 6

		local var_47_0 = {
			zh = 4.4,
			ja = 6
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play322201012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1043ui_story"]) and arg_47_1.var_.characterEffect1043ui_story == nil then
				arg_47_1.var_.characterEffect1043ui_story = arg_47_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1043ui_story"]) then
				if arg_47_1.var_.characterEffect1043ui_story and not isNil(arg_47_1.actors_["1043ui_story"]) then
					arg_47_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1043ui_story"]) and arg_47_1.var_.characterEffect1043ui_story then
				arg_47_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_50_2 = arg_47_1.actors_["1111ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1111ui_story == nil then
				arg_47_1.var_.characterEffect1111ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect1111ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1111ui_story then
				arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_50_4 = 0
			local var_50_5 = 0.55

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(322201011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 22 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 22)

				if (22 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 22)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201011", "story_v_out_322201.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201011", "story_v_out_322201.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_322201", "322201011", "story_v_out_322201.awb")

						arg_47_1:RecordAudio("322201011", var_50_11)
						arg_47_1:RecordAudio("322201011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_322201", "322201011", "story_v_out_322201.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_322201", "322201011", "story_v_out_322201.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play322201012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 322201012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play322201013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1111ui_story = arg_51_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).z)
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles = arg_51_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).z)
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles = arg_51_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1043ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1043ui_story = var_54_1.localPosition
			end

			local var_54_2 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 then
				var_54_1.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_2)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 then
				var_54_1.localPosition = Vector3.New(0, 100, 0)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			if 0.1 < arg_51_1.time_ and arg_51_1.time_ <= 0.1 + arg_54_0 then
				arg_51_1:AudioAction("play", "effect", "minigame_activity_3_7", "minigame_activity_3_7_battle_area", "")
			end

			local var_54_4 = 0
			local var_54_5 = 0.925

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(322201012).content)

				arg_51_1.text_.text = var_54_6

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_8 = 37 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 37)

				if (37 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 37)) > 0 and var_54_5 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8

					if var_54_8 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_6
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_9 and arg_51_1.time_ < var_54_4 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play322201013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322201013
		arg_55_1.duration_ = 7.37

		local var_55_0 = {
			zh = 4.2,
			ja = 7.366
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play322201014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1111ui_story = arg_55_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).z)
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles = arg_55_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_55_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).z)
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles = arg_55_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1111ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1111ui_story == nil then
				arg_55_1.var_.characterEffect1111ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1111ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1111ui_story then
				arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_2")
			end

			local var_58_4 = 0
			local var_58_5 = 0.475

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(322201013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 19 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 19)

				if (19 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 19)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201013", "story_v_out_322201.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201013", "story_v_out_322201.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_322201", "322201013", "story_v_out_322201.awb")

						arg_55_1:RecordAudio("322201013", var_58_11)
						arg_55_1:RecordAudio("322201013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_322201", "322201013", "story_v_out_322201.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_322201", "322201013", "story_v_out_322201.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play322201014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322201014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play322201015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1111ui_story = arg_59_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).z)
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles = arg_59_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).z)
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles = arg_59_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_62_1 = 0
			local var_62_2 = 0.825

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(322201014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 33 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 33)

				if (33 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 33)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play322201015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322201015
		arg_63_1.duration_ = 4.53

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play322201016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_9000

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= 4 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= 4 + 0.3 and arg_63_1.time_ < 4 + 0.3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_0 = "STblack"

			if arg_63_1.bgs_.STblack == nil then
				local var_66_1 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_0)
				var_66_1.name = var_66_0
				var_66_1.transform.parent = arg_63_1.stage_.transform
				var_66_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_0] = var_66_1
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_2 = arg_63_1.bgs_.STblack

				arg_63_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_3 = var_66_2:GetComponent("SpriteRenderer")

				if var_66_3 and var_66_3.sprite then
					local var_66_4 = 2 * (var_66_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_2.transform.localScale = Vector3.New(var_66_4 / var_66_3.sprite.bounds.size.y < var_66_4 * manager.ui.mainCameraCom_.aspect / var_66_3.sprite.bounds.size.x and var_66_4 * manager.ui.mainCameraCom_.aspect / var_66_3.sprite.bounds.size.x or var_66_4 / var_66_3.sprite.bounds.size.y, var_66_4 / var_66_3.sprite.bounds.size.y < var_66_4 * manager.ui.mainCameraCom_.aspect / var_66_3.sprite.bounds.size.x and var_66_4 * manager.ui.mainCameraCom_.aspect / var_66_3.sprite.bounds.size.x or var_66_4 / var_66_3.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "STblack" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_5 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_6 = 2

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_6 then
				local var_66_7 = Color.New(0, 0, 0)

				var_66_7.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_5) / var_66_6)
				arg_63_1.mask_.color = var_66_7
			end

			if arg_63_1.time_ >= var_66_5 + var_66_6 and arg_63_1.time_ < var_66_5 + var_66_6 + arg_66_0 then
				local var_66_8 = Color.New(0, 0, 0)

				var_66_8.a = 1
				arg_63_1.mask_.color = var_66_8
			end

			local var_66_9 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_10 = 1

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_10 then
				local var_66_11 = Color.New(0, 0, 0)

				var_66_11.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_9) / var_66_10)
				arg_63_1.mask_.color = var_66_11
			end

			if arg_63_1.time_ >= var_66_9 + var_66_10 and arg_63_1.time_ < var_66_9 + var_66_10 + arg_66_0 then
				local var_66_12 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_12.a = 0
				arg_63_1.mask_.color = var_66_12
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_13 = arg_63_1.var_.effect10151

				if not arg_63_1.var_.effect10151 then
					var_66_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), manager.ui.mainCamera.transform)
					var_66_13.name = "10151"
					arg_63_1.var_.effect10151 = var_66_13
				else
					var_66_13.transform:SetParent(var_66_9000)
				end

				var_66_13.transform.localPosition = Vector3.New(0, 0, 8.15)
				var_66_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_66_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_66_2, iter_66_3 in ipairs((var_66_13.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_66_3.transform.localScale = Vector3.New(iter_66_3.transform.localScale.x / var_66_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_66_3.transform.localScale.y / var_66_15, iter_66_3.transform.localScale.z)
				end
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 102,
				charCount = 0,
				enableLayoutChange = true,
				duration = 1,
				groupID = "101555",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322201015,
				charCount = 18,
				enableLayoutChange = true,
				duration = 1.2,
				groupID = "1015",
				startTime = 3,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play322201016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322201016
		arg_67_1.duration_ = 2.37

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play322201017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			return
		end

		arg_67_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322201016,
				charCount = 29,
				enableLayoutChange = true,
				duration = 1.93333333333333,
				groupID = "1016",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1015",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play322201017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322201017
		arg_71_1.duration_ = 2.15

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322201018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			return
		end

		arg_71_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322201017,
				charCount = 32,
				enableLayoutChange = true,
				duration = 2.13333333333333,
				groupID = "1017",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1016",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play322201018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322201018
		arg_75_1.duration_ = 2.15

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322201019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			return
		end

		arg_75_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322201018,
				charCount = 31,
				enableLayoutChange = true,
				duration = 2.06666666666667,
				groupID = "1018",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1017",
				duration = 2.13333333333333,
				className = "StoryTextGroupNode",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play322201019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322201019
		arg_79_1.duration_ = 2.48

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322201020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			return
		end

		arg_79_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322201019,
				charCount = 37,
				enableLayoutChange = true,
				duration = 2.46666666666667,
				groupID = "1019",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1018",
				duration = 2.13333333333333,
				className = "StoryTextGroupNode",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play322201020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322201020
		arg_83_1.duration_ = 2.55

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322201021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			return
		end

		arg_83_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322201020,
				charCount = 38,
				enableLayoutChange = true,
				duration = 2.53333333333333,
				groupID = "1020",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1019",
				duration = 2.13333333333333,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play322201021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322201021
		arg_87_1.duration_ = 3.42

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322201022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			return
		end

		arg_87_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322201021,
				charCount = 51,
				enableLayoutChange = true,
				duration = 3.4,
				groupID = "1021",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 60,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 10,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1020",
				duration = 2.13333333333333,
				className = "StoryTextGroupNode",
				startTime = 0.0166666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322201022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322201022
		arg_91_1.duration_ = 5.83

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322201023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 2 < arg_91_1.time_ and arg_91_1.time_ <= 2 + arg_94_0 then
				local var_94_0 = arg_91_1.bgs_.L09f

				arg_91_1.bgs_.L09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_1 = var_94_0:GetComponent("SpriteRenderer")

				if var_94_1 and var_94_1.sprite then
					local var_94_2 = 2 * (var_94_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_0.transform.localScale = Vector3.New(var_94_2 / var_94_1.sprite.bounds.size.y < var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x and var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x or var_94_2 / var_94_1.sprite.bounds.size.y, var_94_2 / var_94_1.sprite.bounds.size.y < var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x and var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x or var_94_2 / var_94_1.sprite.bounds.size.y, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "L09f" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_3 = 4

			if 4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			if arg_91_1.time_ >= var_94_3 + 0.125 and arg_91_1.time_ < var_94_3 + 0.125 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			local var_94_4 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_5 = 2

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_5 then
				local var_94_6 = Color.New(0, 0, 0)

				var_94_6.a = Mathf.Lerp(0, 1, (arg_91_1.time_ - var_94_4) / var_94_5)
				arg_91_1.mask_.color = var_94_6
			end

			if arg_91_1.time_ >= var_94_4 + var_94_5 and arg_91_1.time_ < var_94_4 + var_94_5 + arg_94_0 then
				local var_94_7 = Color.New(0, 0, 0)

				var_94_7.a = 1
				arg_91_1.mask_.color = var_94_7
			end

			local var_94_8 = 2

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_9 = 2

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 then
				local var_94_10 = Color.New(0, 0, 0)

				var_94_10.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_8) / var_94_9)
				arg_91_1.mask_.color = var_94_10
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 then
				local var_94_11 = Color.New(0, 0, 0)

				arg_91_1.mask_.enabled = false
				var_94_11.a = 0
				arg_91_1.mask_.color = var_94_11
			end

			local var_94_12 = arg_91_1.actors_["1111ui_story"].transform

			if 3.83333333333333 < arg_91_1.time_ and arg_91_1.time_ <= 3.83333333333333 + arg_94_0 then
				arg_91_1.var_.moveOldPos1111ui_story = var_94_12.localPosition
			end

			local var_94_13 = 0.001

			if 3.83333333333333 <= arg_91_1.time_ and arg_91_1.time_ < 3.83333333333333 + var_94_13 then
				var_94_12.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_91_1.time_ - 3.83333333333333) / var_94_13)
				var_94_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_12.position).x, (manager.ui.mainCamera.transform.position - var_94_12.position).y, (manager.ui.mainCamera.transform.position - var_94_12.position).z)
				var_94_12.localEulerAngles.z = 0
				var_94_12.localEulerAngles.x = 0
				var_94_12.localEulerAngles = var_94_12.localEulerAngles
			end

			if arg_91_1.time_ >= 3.83333333333333 + var_94_13 and arg_91_1.time_ < 3.83333333333333 + var_94_13 + arg_94_0 then
				var_94_12.localPosition = Vector3.New(0, -0.87, -5.7)
				var_94_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_12.position).x, (manager.ui.mainCamera.transform.position - var_94_12.position).y, (manager.ui.mainCamera.transform.position - var_94_12.position).z)
				var_94_12.localEulerAngles.z = 0
				var_94_12.localEulerAngles.x = 0
				var_94_12.localEulerAngles = var_94_12.localEulerAngles
			end

			local var_94_14 = arg_91_1.actors_["1111ui_story"]

			if 3.83333333333333 < arg_91_1.time_ and arg_91_1.time_ <= 3.83333333333333 + arg_94_0 and not isNil(var_94_14) and arg_91_1.var_.characterEffect1111ui_story == nil then
				arg_91_1.var_.characterEffect1111ui_story = var_94_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_15 = 0.200000002980232

			if 3.83333333333333 <= arg_91_1.time_ and arg_91_1.time_ < 3.83333333333333 + var_94_15 and not isNil(var_94_14) then
				if arg_91_1.var_.characterEffect1111ui_story and not isNil(var_94_14) then
					arg_91_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 3.83333333333333 + var_94_15 and arg_91_1.time_ < 3.83333333333333 + var_94_15 + arg_94_0 and not isNil(var_94_14) and arg_91_1.var_.characterEffect1111ui_story then
				arg_91_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_91_1.time_ and arg_91_1.time_ <= 3.83333333333333 + arg_94_0 then
				arg_91_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 3.83333333333333 < arg_91_1.time_ and arg_91_1.time_ <= 3.83333333333333 + arg_94_0 then
				arg_91_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= 2 + arg_94_0 then
				if arg_91_1.var_.effect10151 then
					Object.Destroy(arg_91_1.var_.effect10151)

					arg_91_1.var_.effect10151 = nil
				end
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_18 = 4
			local var_94_19 = 0.125

			if 4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_18 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_20 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_20:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_21 = arg_91_1:GetWordFromCfg(322201022)
				local var_94_22 = arg_91_1:FormatText(var_94_21.content)

				arg_91_1.text_.text = var_94_22

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_24 = 5 <= 0 and var_94_19 or var_94_19 * (utf8.len(var_94_22) / 5)

				if (5 <= 0 and var_94_19 or var_94_19 * (utf8.len(var_94_22) / 5)) > 0 and var_94_19 < var_94_24 then
					arg_91_1.talkMaxDuration = var_94_24
					var_94_18 = var_94_18 + 0.3

					if var_94_24 + var_94_18 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_24 + var_94_18
					end
				end

				arg_91_1.text_.text = var_94_22
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201022", "story_v_out_322201.awb") ~= 0 then
					local var_94_25 = manager.audio:GetVoiceLength("story_v_out_322201", "322201022", "story_v_out_322201.awb") / 1000

					if var_94_25 + var_94_18 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_25 + var_94_18
					end

					if var_94_21.prefab_name ~= "" and arg_91_1.actors_[var_94_21.prefab_name] ~= nil then
						local var_94_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_21.prefab_name].transform, "story_v_out_322201", "322201022", "story_v_out_322201.awb")

						arg_91_1:RecordAudio("322201022", var_94_26)
						arg_91_1:RecordAudio("322201022", var_94_26)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322201", "322201022", "story_v_out_322201.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322201", "322201022", "story_v_out_322201.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_27 = var_94_18 + 0.3
			local var_94_28 = math.max(var_94_19, arg_91_1.talkMaxDuration)

			if var_94_18 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_27 + var_94_28 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_27) / var_94_28

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_27 + var_94_28 and arg_91_1.time_ < var_94_27 + var_94_28 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "1021",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play322201023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322201023
		arg_97_1.duration_ = 1.4

		local var_97_0 = {
			zh = 1.4,
			ja = 1.3
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
				arg_97_0:Play322201024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1111ui_story = arg_97_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).z)
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles = arg_97_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_97_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).z)
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles = arg_97_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1043ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1043ui_story = var_100_1.localPosition
			end

			local var_100_2 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 then
				var_100_1.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_97_1.time_ - 0) / var_100_2)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 then
				var_100_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			local var_100_3 = arg_97_1.actors_["1043ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1043ui_story == nil then
				arg_97_1.var_.characterEffect1043ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect1043ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1043ui_story then
				arg_97_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_100_6 = arg_97_1.actors_["1111ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1111ui_story == nil then
				arg_97_1.var_.characterEffect1111ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect1111ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1111ui_story then
				arg_97_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_8 = 0
			local var_100_9 = 0.1

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(322201023)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 4 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 4)

				if (4 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 4)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201023", "story_v_out_322201.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_322201", "322201023", "story_v_out_322201.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_322201", "322201023", "story_v_out_322201.awb")

						arg_97_1:RecordAudio("322201023", var_100_15)
						arg_97_1:RecordAudio("322201023", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322201", "322201023", "story_v_out_322201.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322201", "322201023", "story_v_out_322201.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322201024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322201024
		arg_101_1.duration_ = 7.1

		local var_101_0 = {
			zh = 4.366,
			ja = 7.1
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322201025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1111ui_story"]) and arg_101_1.var_.characterEffect1111ui_story == nil then
				arg_101_1.var_.characterEffect1111ui_story = arg_101_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1111ui_story"]) then
				if arg_101_1.var_.characterEffect1111ui_story and not isNil(arg_101_1.actors_["1111ui_story"]) then
					arg_101_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1111ui_story"]) and arg_101_1.var_.characterEffect1111ui_story then
				arg_101_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_104_2 = arg_101_1.actors_["1043ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1043ui_story == nil then
				arg_101_1.var_.characterEffect1043ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect1043ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1043ui_story then
				arg_101_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_104_4 = 0
			local var_104_5 = 0.525

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(322201024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 21 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 21)

				if (21 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 21)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201024", "story_v_out_322201.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201024", "story_v_out_322201.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_322201", "322201024", "story_v_out_322201.awb")

						arg_101_1:RecordAudio("322201024", var_104_11)
						arg_101_1:RecordAudio("322201024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322201", "322201024", "story_v_out_322201.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322201", "322201024", "story_v_out_322201.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play322201025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322201025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322201026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1111ui_story = arg_105_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).z)
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles = arg_105_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).z)
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles = arg_105_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1043ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1043ui_story = var_108_1.localPosition
			end

			local var_108_2 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 then
				var_108_1.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = Vector3.New(0, 100, 0)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if 0.1 < arg_105_1.time_ and arg_105_1.time_ <= 0.1 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_130", "se_story_130_level_clue", "")
			end

			local var_108_4 = 0
			local var_108_5 = 1.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(322201025).content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_8 = 56 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 56)

				if (56 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 56)) > 0 and var_108_5 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_9 and arg_105_1.time_ < var_108_4 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322201026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322201026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322201027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0.3 < arg_109_1.time_ and arg_109_1.time_ <= 0.3 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_11", "se_story_11_blast02", "")
			end

			local var_112_1 = 0
			local var_112_2 = 1.225

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(322201026).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 49 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 49)

				if (49 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 49)) > 0 and var_112_2 < var_112_5 then
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
	Play322201027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322201027
		arg_113_1.duration_ = 2

		local var_113_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_113_0:Play322201028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1111ui_story = arg_113_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1111ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1111ui_story == nil then
				arg_113_1.var_.characterEffect1111ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1111ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1111ui_story then
				arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_116_4 = 0
			local var_116_5 = 0.225

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(322201027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 9 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 9)

				if (9 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 9)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201027", "story_v_out_322201.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_322201", "322201027", "story_v_out_322201.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_322201", "322201027", "story_v_out_322201.awb")

						arg_113_1:RecordAudio("322201027", var_116_11)
						arg_113_1:RecordAudio("322201027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322201", "322201027", "story_v_out_322201.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322201", "322201027", "story_v_out_322201.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play322201028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322201028
		arg_117_1.duration_ = 4.73

		local var_117_0 = {
			zh = 3.6,
			ja = 4.733
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322201029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_120_0 = 0
			local var_120_1 = 0.475

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(322201028)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 19 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 19)

				if (19 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 19)) > 0 and var_120_1 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201028", "story_v_out_322201.awb") ~= 0 then
					local var_120_6 = manager.audio:GetVoiceLength("story_v_out_322201", "322201028", "story_v_out_322201.awb") / 1000

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end

					if var_120_2.prefab_name ~= "" and arg_117_1.actors_[var_120_2.prefab_name] ~= nil then
						local var_120_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_2.prefab_name].transform, "story_v_out_322201", "322201028", "story_v_out_322201.awb")

						arg_117_1:RecordAudio("322201028", var_120_7)
						arg_117_1:RecordAudio("322201028", var_120_7)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_322201", "322201028", "story_v_out_322201.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_322201", "322201028", "story_v_out_322201.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_8 and arg_117_1.time_ < var_120_0 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322201029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322201029
		arg_121_1.duration_ = 1.97

		local var_121_0 = {
			zh = 1.666,
			ja = 1.966
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
				arg_121_0:Play322201030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1111ui_story = arg_121_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).z)
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles = arg_121_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_121_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).z)
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles = arg_121_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1043ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1043ui_story = var_124_1.localPosition
			end

			local var_124_2 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 then
				var_124_1.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_121_1.time_ - 0) / var_124_2)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 then
				var_124_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			local var_124_3 = arg_121_1.actors_["1043ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1043ui_story == nil then
				arg_121_1.var_.characterEffect1043ui_story = var_124_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_4 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 and not isNil(var_124_3) then
				if arg_121_1.var_.characterEffect1043ui_story and not isNil(var_124_3) then
					arg_121_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1043ui_story then
				arg_121_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_124_6 = arg_121_1.actors_["1111ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1111ui_story == nil then
				arg_121_1.var_.characterEffect1111ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_7 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 and not isNil(var_124_6) then
				if arg_121_1.var_.characterEffect1111ui_story and not isNil(var_124_6) then
					arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_7)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1111ui_story then
				arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_8 = 0
			local var_124_9 = 0.2

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(322201029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 8 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 8)

				if (8 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 8)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322201", "322201029", "story_v_out_322201.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_322201", "322201029", "story_v_out_322201.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_322201", "322201029", "story_v_out_322201.awb")

						arg_121_1:RecordAudio("322201029", var_124_15)
						arg_121_1:RecordAudio("322201029", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322201", "322201029", "story_v_out_322201.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322201", "322201029", "story_v_out_322201.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322201030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322201030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
			arg_125_1.auto_ = false
		end

		function arg_125_1.playNext_(arg_127_0)
			arg_125_1.onStoryFinished_()
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1111ui_story = arg_125_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1111ui_story"].transform.position).z)
				arg_125_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1111ui_story"].transform.localEulerAngles = arg_125_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1111ui_story"].transform.position).z)
				arg_125_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1111ui_story"].transform.localEulerAngles = arg_125_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1043ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1043ui_story = var_128_1.localPosition
			end

			local var_128_2 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 then
				var_128_1.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_2)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 then
				var_128_1.localPosition = Vector3.New(0, 100, 0)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			if 0.1 < arg_125_1.time_ and arg_125_1.time_ <= 0.1 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_15", "se_story_15_roar", "")
			end

			local var_128_4 = 0
			local var_128_5 = 1.4

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(322201030).content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_8 = 56 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_6) / 56)

				if (56 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_6) / 56)) > 0 and var_128_5 < var_128_8 then
					arg_125_1.talkMaxDuration = var_128_8

					if var_128_8 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_6
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_9 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_9 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_9

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_9 and arg_125_1.time_ < var_128_4 + var_128_9 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322201.awb"
	}
}
