return {
	Play414091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H07f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07f")
				var_4_0.name = "H07f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H07f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H07f

				arg_1_1.bgs_.H07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H07f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

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

			local var_4_9 = "1016ui_story"

			if arg_1_1.actors_["1016ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1016ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1016ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1016ui_story"].transform

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1.var_.moveOldPos1016ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1016ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_1_1.time_ - 1.9) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.9 + var_4_14 and arg_1_1.time_ < 1.9 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1016ui_story"]

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1016ui_story == nil then
				arg_1_1.var_.characterEffect1016ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1016ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.9 + var_4_16 and arg_1_1.time_ < 1.9 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1016ui_story then
				arg_1_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action6_1")
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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
			local var_4_25 = 0.65

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[971].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414091001).content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 26 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 26)

				if (26 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 26)) > 0 and var_4_25 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_24 = var_4_24 + 0.3

					if var_4_29 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_24 + 0.3
			local var_4_31 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play414091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1035ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1035ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1035ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1035ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1035ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1035ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1035ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -1.05, -5.6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1035ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1035ui_story == nil then
				arg_9_1.var_.characterEffect1035ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1035ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1035ui_story then
				arg_9_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action10_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["1016ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1016ui_story == nil then
				arg_9_1.var_.characterEffect1016ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1016ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1016ui_story then
				arg_9_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_12_10 = 0
			local var_12_11 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[972].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(414091002).content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 11 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 11)

				if (11 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 11)) > 0 and var_12_11 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_15 and arg_9_1.time_ < var_12_10 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play414091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414091003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[972].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(414091003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 20)

				if (20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 20)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play414091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414091004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1016ui_story = arg_17_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1016ui_story"].transform.position).z)
				arg_17_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1016ui_story"].transform.localEulerAngles = arg_17_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_17_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1016ui_story"].transform.position).z)
				arg_17_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1016ui_story"].transform.localEulerAngles = arg_17_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1016ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1016ui_story == nil then
				arg_17_1.var_.characterEffect1016ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1016ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1016ui_story then
				arg_17_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016actionlink/1016action463")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = arg_17_1.actors_["1035ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1035ui_story == nil then
				arg_17_1.var_.characterEffect1035ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect1035ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1035ui_story then
				arg_17_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_20_6 = 0
			local var_20_7 = 1.05

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[971].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(414091004).content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 42 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 42)

				if (42 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 42)) > 0 and var_20_7 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_11 and arg_17_1.time_ < var_20_6 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play414091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414091005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1035ui_story = arg_21_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1035ui_story"].transform.position).z)
				arg_21_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1035ui_story"].transform.localEulerAngles = arg_21_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.6)
				arg_21_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1035ui_story"].transform.position).z)
				arg_21_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1035ui_story"].transform.localEulerAngles = arg_21_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1035ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1035ui_story == nil then
				arg_21_1.var_.characterEffect1035ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1035ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1035ui_story then
				arg_21_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action10_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = arg_21_1.actors_["1016ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1016ui_story == nil then
				arg_21_1.var_.characterEffect1016ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect1016ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1016ui_story then
				arg_21_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_24_6 = 0
			local var_24_7 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[972].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(414091005).content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 20 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_8) / 20)

				if (20 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_8) / 20)) > 0 and var_24_7 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_11 and arg_21_1.time_ < var_24_6 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play414091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414091006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1035ui_story"]) and arg_25_1.var_.characterEffect1035ui_story == nil then
				arg_25_1.var_.characterEffect1035ui_story = arg_25_1.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1035ui_story"]) then
				if arg_25_1.var_.characterEffect1035ui_story and not isNil(arg_25_1.actors_["1035ui_story"]) then
					arg_25_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1035ui_story"]) and arg_25_1.var_.characterEffect1035ui_story then
				arg_25_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action3_2")
			end

			local var_28_1 = arg_25_1.actors_["1016ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1016ui_story == nil then
				arg_25_1.var_.characterEffect1016ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1016ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1016ui_story then
				arg_25_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_28_4 = 0
			local var_28_5 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[971].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(414091006).content)

				arg_25_1.text_.text = var_28_6

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 40 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_6) / 40)

				if (40 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_6) / 40)) > 0 and var_28_5 < var_28_8 then
					arg_25_1.talkMaxDuration = var_28_8

					if var_28_8 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_6
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_9 and arg_25_1.time_ < var_28_4 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play414091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 414091007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play414091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1035ui_story"]) and arg_29_1.var_.characterEffect1035ui_story == nil then
				arg_29_1.var_.characterEffect1035ui_story = arg_29_1.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1035ui_story"]) then
				if arg_29_1.var_.characterEffect1035ui_story and not isNil(arg_29_1.actors_["1035ui_story"]) then
					arg_29_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1035ui_story"]) and arg_29_1.var_.characterEffect1035ui_story then
				arg_29_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["1016ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1016ui_story == nil then
				arg_29_1.var_.characterEffect1016ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1016ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1016ui_story then
				arg_29_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_32_4 = 0
			local var_32_5 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[972].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(414091007).content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 10 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 10)

				if (10 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 10)) > 0 and var_32_5 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_9 and arg_29_1.time_ < var_32_4 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play414091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 414091008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play414091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1016ui_story = arg_33_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1016ui_story"].transform.position).z)
				arg_33_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1016ui_story"].transform.localEulerAngles = arg_33_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_33_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1016ui_story"].transform.position).z)
				arg_33_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1016ui_story"].transform.localEulerAngles = arg_33_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1016ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1016ui_story == nil then
				arg_33_1.var_.characterEffect1016ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1016ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1016ui_story then
				arg_33_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action4_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_4 = arg_33_1.actors_["1035ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1035ui_story == nil then
				arg_33_1.var_.characterEffect1035ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1035ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1035ui_story then
				arg_33_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_36_6 = 0
			local var_36_7 = 0.275

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[971].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(414091008).content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 11 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 11)

				if (11 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 11)) > 0 and var_36_7 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_11 and arg_33_1.time_ < var_36_6 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play414091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 414091009
		arg_37_1.duration_ = 8.8

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play414091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.ST0101 == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0101")
				var_40_0.name = "ST0101"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.ST0101 = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.ST0101

				arg_37_1.bgs_.ST0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST0101" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_5 = 2

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_5 then
				local var_40_6 = Color.New(0, 0, 0)

				var_40_6.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_4) / var_40_5)
				arg_37_1.mask_.color = var_40_6
			end

			if arg_37_1.time_ >= var_40_4 + var_40_5 and arg_37_1.time_ < var_40_4 + var_40_5 + arg_40_0 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = 1
				arg_37_1.mask_.color = var_40_7
			end

			local var_40_8 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 then
				local var_40_10 = Color.New(0, 0, 0)

				var_40_10.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_8) / var_40_9)
				arg_37_1.mask_.color = var_40_10
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 then
				local var_40_11 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_11.a = 0
				arg_37_1.mask_.color = var_40_11
			end

			local var_40_12 = arg_37_1.actors_["1035ui_story"].transform

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1.var_.moveOldPos1035ui_story = var_40_12.localPosition
			end

			local var_40_13 = 0.001

			if 2 <= arg_37_1.time_ and arg_37_1.time_ < 2 + var_40_13 then
				var_40_12.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 2) / var_40_13)
				var_40_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_12.position).x, (manager.ui.mainCamera.transform.position - var_40_12.position).y, (manager.ui.mainCamera.transform.position - var_40_12.position).z)
				var_40_12.localEulerAngles.z = 0
				var_40_12.localEulerAngles.x = 0
				var_40_12.localEulerAngles = var_40_12.localEulerAngles
			end

			if arg_37_1.time_ >= 2 + var_40_13 and arg_37_1.time_ < 2 + var_40_13 + arg_40_0 then
				var_40_12.localPosition = Vector3.New(0, 100, 0)
				var_40_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_12.position).x, (manager.ui.mainCamera.transform.position - var_40_12.position).y, (manager.ui.mainCamera.transform.position - var_40_12.position).z)
				var_40_12.localEulerAngles.z = 0
				var_40_12.localEulerAngles.x = 0
				var_40_12.localEulerAngles = var_40_12.localEulerAngles
			end

			local var_40_14 = arg_37_1.actors_["1016ui_story"].transform

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1.var_.moveOldPos1016ui_story = var_40_14.localPosition
			end

			local var_40_15 = 0.001

			if 2 <= arg_37_1.time_ and arg_37_1.time_ < 2 + var_40_15 then
				var_40_14.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 2) / var_40_15)
				var_40_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_14.position).x, (manager.ui.mainCamera.transform.position - var_40_14.position).y, (manager.ui.mainCamera.transform.position - var_40_14.position).z)
				var_40_14.localEulerAngles.z = 0
				var_40_14.localEulerAngles.x = 0
				var_40_14.localEulerAngles = var_40_14.localEulerAngles
			end

			if arg_37_1.time_ >= 2 + var_40_15 and arg_37_1.time_ < 2 + var_40_15 + arg_40_0 then
				var_40_14.localPosition = Vector3.New(0, 100, 0)
				var_40_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_14.position).x, (manager.ui.mainCamera.transform.position - var_40_14.position).y, (manager.ui.mainCamera.transform.position - var_40_14.position).z)
				var_40_14.localEulerAngles.z = 0
				var_40_14.localEulerAngles.x = 0
				var_40_14.localEulerAngles = var_40_14.localEulerAngles
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_16 = 3.8
			local var_40_17 = 0.75

			if 3.8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_18 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_18:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[973].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_designera")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_19 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(414091009).content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 30 <= 0 and var_40_17 or var_40_17 * (utf8.len(var_40_19) / 30)

				if (30 <= 0 and var_40_17 or var_40_17 * (utf8.len(var_40_19) / 30)) > 0 and var_40_17 < var_40_21 then
					arg_37_1.talkMaxDuration = var_40_21
					var_40_16 = var_40_16 + 0.3

					if var_40_21 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_16
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = var_40_16 + 0.3
			local var_40_23 = math.max(var_40_17, arg_37_1.talkMaxDuration)

			if var_40_16 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_22 + var_40_23 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_22) / var_40_23

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_22 + var_40_23 and arg_37_1.time_ < var_40_22 + var_40_23 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play414091010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 414091010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play414091011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.85

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[973].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_designera")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(414091010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 34 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 34)

				if (34 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 34)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play414091011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 414091011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play414091012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[973].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_designera")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(414091011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 61 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 61)

				if (61 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 61)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play414091012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414091012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play414091013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.65

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[973].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_designera")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(414091012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 66 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 66)

				if (66 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 66)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play414091013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 414091013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play414091014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.95

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[973].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_designera")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(414091013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 38 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 38)

				if (38 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 38)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play414091014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 414091014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play414091015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.65

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[974].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(414091014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 26 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 26)

				if (26 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 26)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play414091015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 414091015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play414091016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.15

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[973].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_designera")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(414091015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 46 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 46)

				if (46 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 46)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play414091016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 414091016
		arg_67_1.duration_ = 7.83

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play414091017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.bgs_.H07h == nil then
				local var_70_0 = Object.Instantiate(arg_67_1.paintGo_)

				var_70_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07h")
				var_70_0.name = "H07h"
				var_70_0.transform.parent = arg_67_1.stage_.transform
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.bgs_.H07h = var_70_0
			end

			if 1 < arg_67_1.time_ and arg_67_1.time_ <= 1 + arg_70_0 then
				local var_70_1 = arg_67_1.bgs_.H07h

				arg_67_1.bgs_.H07h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_70_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_70_2 = var_70_1:GetComponent("SpriteRenderer")

				if var_70_2 and var_70_2.sprite then
					local var_70_3 = 2 * (var_70_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_70_1.transform.localScale = Vector3.New(var_70_3 / var_70_2.sprite.bounds.size.y < var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x and var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x or var_70_3 / var_70_2.sprite.bounds.size.y, var_70_3 / var_70_2.sprite.bounds.size.y < var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x and var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x or var_70_3 / var_70_2.sprite.bounds.size.y, 0)
				end

				for iter_70_0, iter_70_1 in pairs(arg_67_1.bgs_) do
					if iter_70_0 ~= "H07h" then
						iter_70_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_70_4 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			if arg_67_1.time_ >= var_70_4 + 0.3 and arg_67_1.time_ < var_70_4 + 0.3 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_5 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_6 = 1

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_6 then
				local var_70_7 = Color.New(0, 0, 0)

				var_70_7.a = Mathf.Lerp(0, 1, (arg_67_1.time_ - var_70_5) / var_70_6)
				arg_67_1.mask_.color = var_70_7
			end

			if arg_67_1.time_ >= var_70_5 + var_70_6 and arg_67_1.time_ < var_70_5 + var_70_6 + arg_70_0 then
				local var_70_8 = Color.New(0, 0, 0)

				var_70_8.a = 1
				arg_67_1.mask_.color = var_70_8
			end

			local var_70_9 = 1

			if 1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_10 = 2

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_10 then
				local var_70_11 = Color.New(0, 0, 0)

				var_70_11.a = Mathf.Lerp(1, 0, (arg_67_1.time_ - var_70_9) / var_70_10)
				arg_67_1.mask_.color = var_70_11
			end

			if arg_67_1.time_ >= var_70_9 + var_70_10 and arg_67_1.time_ < var_70_9 + var_70_10 + arg_70_0 then
				local var_70_12 = Color.New(0, 0, 0)

				arg_67_1.mask_.enabled = false
				var_70_12.a = 0
				arg_67_1.mask_.color = var_70_12
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_13 = 2.83333333333333
			local var_70_14 = 0.475

			if 2.83333333333333 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_15 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_15:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_16 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(414091016).content)

				arg_67_1.text_.text = var_70_16

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_18 = 19 <= 0 and var_70_14 or var_70_14 * (utf8.len(var_70_16) / 19)

				if (19 <= 0 and var_70_14 or var_70_14 * (utf8.len(var_70_16) / 19)) > 0 and var_70_14 < var_70_18 then
					arg_67_1.talkMaxDuration = var_70_18
					var_70_13 = var_70_13 + 0.3

					if var_70_18 + var_70_13 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_18 + var_70_13
					end
				end

				arg_67_1.text_.text = var_70_16
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_19 = var_70_13 + 0.3
			local var_70_20 = math.max(var_70_14, arg_67_1.talkMaxDuration)

			if var_70_13 + 0.3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_19 + var_70_20 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_19) / var_70_20

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_19 + var_70_20 and arg_67_1.time_ < var_70_19 + var_70_20 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play414091017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 414091017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play414091018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_76_0 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_73_1.stage_.transform)

				var_76_0.name = "1049ui_story"
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1049ui_story"] = var_76_0

				local var_76_1 = var_76_0:GetComponentInChildren(typeof(CharacterEffect))

				var_76_1.enabled = true

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_1.transform, false)

				arg_73_1.var_["1049ui_story" .. "Animator"] = var_76_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_["1049ui_story" .. "Animator"].applyRootMotion = true
				arg_73_1.var_["1049ui_story" .. "LipSync"] = var_76_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_3 = arg_73_1.actors_["1049ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1049ui_story = var_76_3.localPosition

				arg_73_1:ShowWeapon(arg_73_1.var_["1049ui_story" .. "Animator"].transform, false)
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_73_1.time_ - 0) / var_76_4)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0, -1.2, -6)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			local var_76_5 = arg_73_1.actors_["1049ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1049ui_story == nil then
				arg_73_1.var_.characterEffect1049ui_story = var_76_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.characterEffect1049ui_story and not isNil(var_76_5) then
					arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1049ui_story then
				arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_8 = 0
			local var_76_9 = 0.7

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(414091017).content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_12 = 28 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_10) / 28)

				if (28 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_10) / 28)) > 0 and var_76_9 < var_76_12 then
					arg_73_1.talkMaxDuration = var_76_12

					if var_76_12 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_13 and arg_73_1.time_ < var_76_8 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play414091018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 414091018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play414091019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1049ui_story"]) and arg_77_1.var_.characterEffect1049ui_story == nil then
				arg_77_1.var_.characterEffect1049ui_story = arg_77_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1049ui_story"]) then
				if arg_77_1.var_.characterEffect1049ui_story and not isNil(arg_77_1.actors_["1049ui_story"]) then
					arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1049ui_story"]) and arg_77_1.var_.characterEffect1049ui_story then
				arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_80_1 = arg_77_1.actors_["1049ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1049ui_story = var_80_1.localPosition

				arg_77_1:ShowWeapon(arg_77_1.var_["1049ui_story" .. "Animator"].transform, false)
			end

			local var_80_2 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_2)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			local var_80_3 = 0
			local var_80_4 = 1.6

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(414091018).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 64 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 64)

				if (64 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 64)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play414091019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 414091019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play414091020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(414091019).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 47 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 47)

				if (47 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 47)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play414091020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 414091020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play414091021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(414091020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 26 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 26)

				if (26 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 26)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play414091021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 414091021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play414091022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.725

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(414091021).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 29 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 29)

				if (29 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 29)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play414091022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 414091022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play414091023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.375

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
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

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(414091022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 15 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 15)

				if (15 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 15)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play414091023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 414091023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play414091024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1049ui_story = arg_97_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1049ui_story"].transform.position).z)
				arg_97_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1049ui_story"].transform.localEulerAngles = arg_97_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_97_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1049ui_story"].transform.position).z)
				arg_97_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1049ui_story"].transform.localEulerAngles = arg_97_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1049ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1049ui_story == nil then
				arg_97_1.var_.characterEffect1049ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1049ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1049ui_story then
				arg_97_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.075

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(414091023).content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 3 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 3)

				if (3 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 3)) > 0 and var_100_5 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_9 and arg_97_1.time_ < var_100_4 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play414091024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 414091024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play414091025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1049ui_story"]) and arg_101_1.var_.characterEffect1049ui_story == nil then
				arg_101_1.var_.characterEffect1049ui_story = arg_101_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1049ui_story"]) then
				if arg_101_1.var_.characterEffect1049ui_story and not isNil(arg_101_1.actors_["1049ui_story"]) then
					arg_101_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1049ui_story"]) and arg_101_1.var_.characterEffect1049ui_story then
				arg_101_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.05

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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(414091024).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 2 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 2)

				if (2 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 2)) > 0 and var_104_2 < var_104_5 then
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
	Play414091025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 414091025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play414091026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(414091025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 19 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 19)

				if (19 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 19)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play414091026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 414091026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play414091027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1049ui_story = arg_109_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).z)
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles = arg_109_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_109_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1049ui_story"].transform.position).z)
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1049ui_story"].transform.localEulerAngles = arg_109_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1049ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1049ui_story == nil then
				arg_109_1.var_.characterEffect1049ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1049ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1049ui_story then
				arg_109_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.275

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(414091026).content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 11 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_6) / 11)

				if (11 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_6) / 11)) > 0 and var_112_5 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_9 and arg_109_1.time_ < var_112_4 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play414091027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 414091027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play414091028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1049ui_story"]) and arg_113_1.var_.characterEffect1049ui_story == nil then
				arg_113_1.var_.characterEffect1049ui_story = arg_113_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1049ui_story"]) then
				if arg_113_1.var_.characterEffect1049ui_story and not isNil(arg_113_1.actors_["1049ui_story"]) then
					arg_113_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1049ui_story"]) and arg_113_1.var_.characterEffect1049ui_story then
				arg_113_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.575

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(414091027).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 23 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 23)

				if (23 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 23)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play414091028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 414091028
		arg_117_1.duration_ = 8.7

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play414091029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.H07h

				arg_117_1.bgs_.H07h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "H07h" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_4 = 2

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_4 then
				local var_120_5 = Color.New(0, 0, 0)

				var_120_5.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_3) / var_120_4)
				arg_117_1.mask_.color = var_120_5
			end

			if arg_117_1.time_ >= var_120_3 + var_120_4 and arg_117_1.time_ < var_120_3 + var_120_4 + arg_120_0 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = 1
				arg_117_1.mask_.color = var_120_6
			end

			local var_120_7 = 2

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_8 = 2

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				local var_120_9 = Color.New(0, 0, 0)

				var_120_9.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_7) / var_120_8)
				arg_117_1.mask_.color = var_120_9
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				local var_120_10 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_10.a = 0
				arg_117_1.mask_.color = var_120_10
			end

			local var_120_11 = arg_117_1.actors_["1049ui_story"].transform

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				arg_117_1.var_.moveOldPos1049ui_story = var_120_11.localPosition

				arg_117_1:ShowWeapon(arg_117_1.var_["1049ui_story" .. "Animator"].transform, false)
			end

			local var_120_12 = 0.001

			if 2 <= arg_117_1.time_ and arg_117_1.time_ < 2 + var_120_12 then
				var_120_11.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 2) / var_120_12)
				var_120_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_11.position).x, (manager.ui.mainCamera.transform.position - var_120_11.position).y, (manager.ui.mainCamera.transform.position - var_120_11.position).z)
				var_120_11.localEulerAngles.z = 0
				var_120_11.localEulerAngles.x = 0
				var_120_11.localEulerAngles = var_120_11.localEulerAngles
			end

			if arg_117_1.time_ >= 2 + var_120_12 and arg_117_1.time_ < 2 + var_120_12 + arg_120_0 then
				var_120_11.localPosition = Vector3.New(0, 100, 0)
				var_120_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_11.position).x, (manager.ui.mainCamera.transform.position - var_120_11.position).y, (manager.ui.mainCamera.transform.position - var_120_11.position).z)
				var_120_11.localEulerAngles.z = 0
				var_120_11.localEulerAngles.x = 0
				var_120_11.localEulerAngles = var_120_11.localEulerAngles
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_13 = 3.7
			local var_120_14 = 0.95

			if 3.7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_15 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_15:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_16 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(414091028).content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_18 = 38 <= 0 and var_120_14 or var_120_14 * (utf8.len(var_120_16) / 38)

				if (38 <= 0 and var_120_14 or var_120_14 * (utf8.len(var_120_16) / 38)) > 0 and var_120_14 < var_120_18 then
					arg_117_1.talkMaxDuration = var_120_18
					var_120_13 = var_120_13 + 0.3

					if var_120_18 + var_120_13 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_13
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_19 = var_120_13 + 0.3
			local var_120_20 = math.max(var_120_14, arg_117_1.talkMaxDuration)

			if var_120_13 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_19 + var_120_20 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_19) / var_120_20

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_19 + var_120_20 and arg_117_1.time_ < var_120_19 + var_120_20 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play414091029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 414091029
		arg_123_1.duration_ = 5.73

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play414091030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_0 = 0.733333333333333
			local var_126_1 = 0.5

			if 0.733333333333333 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_2 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_2:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(414091029).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 20 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 20)

				if (20 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 20)) > 0 and var_126_1 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5
					var_126_0 = var_126_0 + 0.3

					if var_126_5 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = var_126_0 + 0.3
			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_7 and arg_123_1.time_ < var_126_6 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play414091030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 414091030
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play414091031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1049ui_story = arg_129_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1049ui_story"].transform.position).z)
				arg_129_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1049ui_story"].transform.localEulerAngles = arg_129_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_129_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1049ui_story"].transform.position).z)
				arg_129_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1049ui_story"].transform.localEulerAngles = arg_129_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1049ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1049ui_story == nil then
				arg_129_1.var_.characterEffect1049ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1049ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1049ui_story then
				arg_129_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.2

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(414091030).content)

				arg_129_1.text_.text = var_132_6

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_8 = 8 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_6) / 8)

				if (8 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_6) / 8)) > 0 and var_132_5 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_6
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_9 and arg_129_1.time_ < var_132_4 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play414091031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 414091031
		arg_133_1.duration_ = 1

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"

			SetActive(arg_133_1.choicesGo_, true)

			for iter_134_0, iter_134_1 in ipairs(arg_133_1.choices_) do
				SetActive(iter_134_1.go, iter_134_0 <= 2)
			end

			arg_133_1.choices_[1].txt.text = arg_133_1:FormatText(StoryChoiceCfg[839].name)
			arg_133_1.choices_[2].txt.text = arg_133_1:FormatText(StoryChoiceCfg[840].name)
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play414091032(arg_133_1)
			end

			if arg_135_0 == 2 then
				arg_133_0:Play414091034(arg_133_1)
			end

			arg_133_1:RecordChoiceLog(414091031, 839, 840)
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1049ui_story"]) and arg_133_1.var_.characterEffect1049ui_story == nil then
				arg_133_1.var_.characterEffect1049ui_story = arg_133_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1049ui_story"]) then
				if arg_133_1.var_.characterEffect1049ui_story and not isNil(arg_133_1.actors_["1049ui_story"]) then
					arg_133_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1049ui_story"]) and arg_133_1.var_.characterEffect1049ui_story then
				arg_133_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play414091032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 414091032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play414091033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1049ui_story"]) and arg_137_1.var_.characterEffect1049ui_story == nil then
				arg_137_1.var_.characterEffect1049ui_story = arg_137_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1049ui_story"]) then
				if arg_137_1.var_.characterEffect1049ui_story and not isNil(arg_137_1.actors_["1049ui_story"]) then
					arg_137_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1049ui_story"]) and arg_137_1.var_.characterEffect1049ui_story then
				arg_137_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_140_2 = 0
			local var_140_3 = 0.225

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(414091032).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 9 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 9)

				if (9 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 9)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play414091033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 414091033
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play414091036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1049ui_story"]) and arg_141_1.var_.characterEffect1049ui_story == nil then
				arg_141_1.var_.characterEffect1049ui_story = arg_141_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1049ui_story"]) then
				if arg_141_1.var_.characterEffect1049ui_story and not isNil(arg_141_1.actors_["1049ui_story"]) then
					arg_141_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1049ui_story"]) and arg_141_1.var_.characterEffect1049ui_story then
				arg_141_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.675

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

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(414091033).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 27 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 27)

				if (27 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 27)) > 0 and var_144_2 < var_144_5 then
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
	Play414091036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 414091036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play414091037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.2

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(414091036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 8 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 8)

				if (8 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 8)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play414091037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 414091037
		arg_149_1.duration_ = 7.8

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play414091038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.bgs_.H07g == nil then
				local var_152_0 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07g")
				var_152_0.name = "H07g"
				var_152_0.transform.parent = arg_149_1.stage_.transform
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_.H07g = var_152_0
			end

			if 1 < arg_149_1.time_ and arg_149_1.time_ <= 1 + arg_152_0 then
				local var_152_1 = arg_149_1.bgs_.H07g

				arg_149_1.bgs_.H07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_2 = var_152_1:GetComponent("SpriteRenderer")

				if var_152_2 and var_152_2.sprite then
					local var_152_3 = 2 * (var_152_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_1.transform.localScale = Vector3.New(var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "H07g" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_4 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_5 = 1

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_5 then
				local var_152_6 = Color.New(0, 0, 0)

				var_152_6.a = Mathf.Lerp(0, 1, (arg_149_1.time_ - var_152_4) / var_152_5)
				arg_149_1.mask_.color = var_152_6
			end

			if arg_149_1.time_ >= var_152_4 + var_152_5 and arg_149_1.time_ < var_152_4 + var_152_5 + arg_152_0 then
				local var_152_7 = Color.New(0, 0, 0)

				var_152_7.a = 1
				arg_149_1.mask_.color = var_152_7
			end

			local var_152_8 = 1

			if 1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_9 = 2

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_9 then
				local var_152_10 = Color.New(0, 0, 0)

				var_152_10.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_8) / var_152_9)
				arg_149_1.mask_.color = var_152_10
			end

			if arg_149_1.time_ >= var_152_8 + var_152_9 and arg_149_1.time_ < var_152_8 + var_152_9 + arg_152_0 then
				local var_152_11 = Color.New(0, 0, 0)

				arg_149_1.mask_.enabled = false
				var_152_11.a = 0
				arg_149_1.mask_.color = var_152_11
			end

			local var_152_12 = arg_149_1.actors_["1049ui_story"].transform

			if 1 < arg_149_1.time_ and arg_149_1.time_ <= 1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1049ui_story = var_152_12.localPosition
			end

			local var_152_13 = 0.001

			if 1 <= arg_149_1.time_ and arg_149_1.time_ < 1 + var_152_13 then
				var_152_12.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 1) / var_152_13)
				var_152_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_12.position).x, (manager.ui.mainCamera.transform.position - var_152_12.position).y, (manager.ui.mainCamera.transform.position - var_152_12.position).z)
				var_152_12.localEulerAngles.z = 0
				var_152_12.localEulerAngles.x = 0
				var_152_12.localEulerAngles = var_152_12.localEulerAngles
			end

			if arg_149_1.time_ >= 1 + var_152_13 and arg_149_1.time_ < 1 + var_152_13 + arg_152_0 then
				var_152_12.localPosition = Vector3.New(0, 100, 0)
				var_152_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_12.position).x, (manager.ui.mainCamera.transform.position - var_152_12.position).y, (manager.ui.mainCamera.transform.position - var_152_12.position).z)
				var_152_12.localEulerAngles.z = 0
				var_152_12.localEulerAngles.x = 0
				var_152_12.localEulerAngles = var_152_12.localEulerAngles
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_14 = 2.8
			local var_152_15 = 0.95

			if 2.8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_16 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_16:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_17 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(414091037).content)

				arg_149_1.text_.text = var_152_17

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_19 = 38 <= 0 and var_152_15 or var_152_15 * (utf8.len(var_152_17) / 38)

				if (38 <= 0 and var_152_15 or var_152_15 * (utf8.len(var_152_17) / 38)) > 0 and var_152_15 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19
					var_152_14 = var_152_14 + 0.3

					if var_152_19 + var_152_14 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_14
					end
				end

				arg_149_1.text_.text = var_152_17
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_20 = var_152_14 + 0.3
			local var_152_21 = math.max(var_152_15, arg_149_1.talkMaxDuration)

			if var_152_14 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_20 + var_152_21 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_20) / var_152_21

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_20 + var_152_21 and arg_149_1.time_ < var_152_20 + var_152_21 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play414091038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 414091038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play414091039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.65

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(414091038).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 26 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 26)

				if (26 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 26)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play414091039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 414091039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play414091040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1049ui_story = arg_159_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1049ui_story"].transform.position).z)
				arg_159_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1049ui_story"].transform.localEulerAngles = arg_159_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_159_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1049ui_story"].transform.position).z)
				arg_159_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1049ui_story"].transform.localEulerAngles = arg_159_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1049ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1049ui_story == nil then
				arg_159_1.var_.characterEffect1049ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1049ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1049ui_story then
				arg_159_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_1")
			end

			local var_162_4 = 0
			local var_162_5 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(414091039).content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_8 = 14 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_6) / 14)

				if (14 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_6) / 14)) > 0 and var_162_5 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_9 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_9 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_9

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_9 and arg_159_1.time_ < var_162_4 + var_162_9 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play414091040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 414091040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play414091041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1049ui_story"]) and arg_163_1.var_.characterEffect1049ui_story == nil then
				arg_163_1.var_.characterEffect1049ui_story = arg_163_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1049ui_story"]) then
				if arg_163_1.var_.characterEffect1049ui_story and not isNil(arg_163_1.actors_["1049ui_story"]) then
					arg_163_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1049ui_story"]) and arg_163_1.var_.characterEffect1049ui_story then
				arg_163_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.725

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(414091040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 29 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 29)

				if (29 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 29)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play414091041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 414091041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play414091042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1049ui_story = arg_167_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1049ui_story"].transform.position).z)
				arg_167_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1049ui_story"].transform.localEulerAngles = arg_167_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_167_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1049ui_story"].transform.position).z)
				arg_167_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1049ui_story"].transform.localEulerAngles = arg_167_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1049ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1049ui_story == nil then
				arg_167_1.var_.characterEffect1049ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1049ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1049ui_story then
				arg_167_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_4 = 0
			local var_170_5 = 0.175

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(414091041).content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 7 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 7)

				if (7 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 7)) > 0 and var_170_5 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_9 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_9 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_9

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_9 and arg_167_1.time_ < var_170_4 + var_170_9 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play414091042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 414091042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play414091043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1049ui_story"]) and arg_171_1.var_.characterEffect1049ui_story == nil then
				arg_171_1.var_.characterEffect1049ui_story = arg_171_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1049ui_story"]) then
				if arg_171_1.var_.characterEffect1049ui_story and not isNil(arg_171_1.actors_["1049ui_story"]) then
					arg_171_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1049ui_story"]) and arg_171_1.var_.characterEffect1049ui_story then
				arg_171_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_174_1 = arg_171_1.actors_["1049ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1049ui_story = var_174_1.localPosition

				arg_171_1:ShowWeapon(arg_171_1.var_["1049ui_story" .. "Animator"].transform, false)
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(0, 100, 0)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = 0
			local var_174_4 = 1.025

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_5 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(414091042).content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 41 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 41)

				if (41 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 41)) > 0 and var_174_4 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_3
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_4, arg_171_1.talkMaxDuration)

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_3) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_3 + var_174_8 and arg_171_1.time_ < var_174_3 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play414091043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 414091043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play414091044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1049ui_story = arg_175_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1049ui_story"].transform.position).z)
				arg_175_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1049ui_story"].transform.localEulerAngles = arg_175_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1049ui_story"].transform.position).z)
				arg_175_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1049ui_story"].transform.localEulerAngles = arg_175_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_178_1 = 0
			local var_178_2 = 0.8

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(414091043).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 32 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 32)

				if (32 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 32)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play414091044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 414091044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play414091045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.2

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(414091044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 8 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 8)

				if (8 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 8)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play414091045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 414091045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play414091046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1016ui_story = arg_183_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1016ui_story"].transform.position).z)
				arg_183_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1016ui_story"].transform.localEulerAngles = arg_183_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, -18.66, -121.78)
				arg_183_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1016ui_story"].transform.position).z)
				arg_183_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1016ui_story"].transform.localEulerAngles = arg_183_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1016ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1016ui_story == nil then
				arg_183_1.var_.characterEffect1016ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1016ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1016ui_story then
				arg_183_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action4_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_186_4 = arg_183_1.actors_["1049ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1049ui_story = var_186_4.localPosition
			end

			local var_186_5 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_5 then
				var_186_4.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_5)
				var_186_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_4.position).x, (manager.ui.mainCamera.transform.position - var_186_4.position).y, (manager.ui.mainCamera.transform.position - var_186_4.position).z)
				var_186_4.localEulerAngles.z = 0
				var_186_4.localEulerAngles.x = 0
				var_186_4.localEulerAngles = var_186_4.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_5 and arg_183_1.time_ < 0 + var_186_5 + arg_186_0 then
				var_186_4.localPosition = Vector3.New(0, 100, 0)
				var_186_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_4.position).x, (manager.ui.mainCamera.transform.position - var_186_4.position).y, (manager.ui.mainCamera.transform.position - var_186_4.position).z)
				var_186_4.localEulerAngles.z = 0
				var_186_4.localEulerAngles.x = 0
				var_186_4.localEulerAngles = var_186_4.localEulerAngles
			end

			local var_186_6 = 0
			local var_186_7 = 0.375

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(414091045).content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 15 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_8) / 15)

				if (15 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_8) / 15)) > 0 and var_186_7 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_11 and arg_183_1.time_ < var_186_6 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play414091046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 414091046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play414091047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1016ui_story"]) and arg_187_1.var_.characterEffect1016ui_story == nil then
				arg_187_1.var_.characterEffect1016ui_story = arg_187_1.actors_["1016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1016ui_story"]) then
				if arg_187_1.var_.characterEffect1016ui_story and not isNil(arg_187_1.actors_["1016ui_story"]) then
					arg_187_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1016ui_story"]) and arg_187_1.var_.characterEffect1016ui_story then
				arg_187_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.6

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(414091046).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 24 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 24)

				if (24 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 24)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play414091047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 414091047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play414091048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1016ui_story = arg_191_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1016ui_story"].transform.position).z)
				arg_191_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1016ui_story"].transform.localEulerAngles = arg_191_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_191_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1016ui_story"].transform.position).z)
				arg_191_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1016ui_story"].transform.localEulerAngles = arg_191_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1035ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1035ui_story = var_194_1.localPosition
			end

			local var_194_2 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 then
				var_194_1.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_191_1.time_ - 0) / var_194_2)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 then
				var_194_1.localPosition = Vector3.New(0.7, -1.05, -5.6)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			local var_194_3 = arg_191_1.actors_["1035ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect1035ui_story == nil then
				arg_191_1.var_.characterEffect1035ui_story = var_194_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 and not isNil(var_194_3) then
				if arg_191_1.var_.characterEffect1035ui_story and not isNil(var_194_3) then
					arg_191_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect1035ui_story then
				arg_191_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action2_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_6 = 0
			local var_194_7 = 0.375

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(414091047).content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 15 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_8) / 15)

				if (15 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_8) / 15)) > 0 and var_194_7 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_11 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_11 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_11

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_11 and arg_191_1.time_ < var_194_6 + var_194_11 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play414091048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 414091048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play414091049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1035ui_story"]) and arg_195_1.var_.characterEffect1035ui_story == nil then
				arg_195_1.var_.characterEffect1035ui_story = arg_195_1.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1035ui_story"]) then
				if arg_195_1.var_.characterEffect1035ui_story and not isNil(arg_195_1.actors_["1035ui_story"]) then
					arg_195_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1035ui_story"]) and arg_195_1.var_.characterEffect1035ui_story then
				arg_195_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.1

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(414091048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 4 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 4)

				if (4 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 4)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play414091049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 414091049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play414091050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1035ui_story"]) and arg_199_1.var_.characterEffect1035ui_story == nil then
				arg_199_1.var_.characterEffect1035ui_story = arg_199_1.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1035ui_story"]) then
				if arg_199_1.var_.characterEffect1035ui_story and not isNil(arg_199_1.actors_["1035ui_story"]) then
					arg_199_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1035ui_story"]) and arg_199_1.var_.characterEffect1035ui_story then
				arg_199_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_202_2 = 0
			local var_202_3 = 0.3

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_4 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(414091049).content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 12 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_4) / 12)

				if (12 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_4) / 12)) > 0 and var_202_3 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_7 and arg_199_1.time_ < var_202_2 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play414091050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 414091050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play414091051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1035ui_story"]) and arg_203_1.var_.characterEffect1035ui_story == nil then
				arg_203_1.var_.characterEffect1035ui_story = arg_203_1.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1035ui_story"]) then
				if arg_203_1.var_.characterEffect1035ui_story and not isNil(arg_203_1.actors_["1035ui_story"]) then
					arg_203_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1035ui_story"]) and arg_203_1.var_.characterEffect1035ui_story then
				arg_203_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.05

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(414091050).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 2 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 2)

				if (2 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 2)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play414091051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 414091051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play414091052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1035ui_story = arg_207_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1035ui_story"].transform.position).z)
				arg_207_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1035ui_story"].transform.localEulerAngles = arg_207_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.6)
				arg_207_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1035ui_story"].transform.position).z)
				arg_207_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1035ui_story"].transform.localEulerAngles = arg_207_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1035ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1035ui_story == nil then
				arg_207_1.var_.characterEffect1035ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1035ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1035ui_story then
				arg_207_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action428")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_210_4 = 0
			local var_210_5 = 0.325

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(414091051).content)

				arg_207_1.text_.text = var_210_6

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_8 = 13 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_6) / 13)

				if (13 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_6) / 13)) > 0 and var_210_5 < var_210_8 then
					arg_207_1.talkMaxDuration = var_210_8

					if var_210_8 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_6
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_9 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_9 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_9

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_9 and arg_207_1.time_ < var_210_4 + var_210_9 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play414091052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 414091052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play414091053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1035ui_story"]) and arg_211_1.var_.characterEffect1035ui_story == nil then
				arg_211_1.var_.characterEffect1035ui_story = arg_211_1.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1035ui_story"]) then
				if arg_211_1.var_.characterEffect1035ui_story and not isNil(arg_211_1.actors_["1035ui_story"]) then
					arg_211_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1035ui_story"]) and arg_211_1.var_.characterEffect1035ui_story then
				arg_211_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_214_1 = 0
			local var_214_2 = 0.55

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(414091052).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 22 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 22)

				if (22 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 22)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play414091053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 414091053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play414091054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1016ui_story = arg_215_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1016ui_story"].transform.position).z)
				arg_215_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1016ui_story"].transform.localEulerAngles = arg_215_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_215_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1016ui_story"].transform.position).z)
				arg_215_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1016ui_story"].transform.localEulerAngles = arg_215_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1016ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1016ui_story == nil then
				arg_215_1.var_.characterEffect1016ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1016ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1016ui_story then
				arg_215_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action4_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_4 = 0
			local var_218_5 = 0.125

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(414091053).content)

				arg_215_1.text_.text = var_218_6

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_8 = 5 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_6) / 5)

				if (5 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_6) / 5)) > 0 and var_218_5 < var_218_8 then
					arg_215_1.talkMaxDuration = var_218_8

					if var_218_8 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_6
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_9 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_9 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_9

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_9 and arg_215_1.time_ < var_218_4 + var_218_9 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play414091054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 414091054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play414091055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1016ui_story"]) and arg_219_1.var_.characterEffect1016ui_story == nil then
				arg_219_1.var_.characterEffect1016ui_story = arg_219_1.actors_["1016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1016ui_story"]) then
				if arg_219_1.var_.characterEffect1016ui_story and not isNil(arg_219_1.actors_["1016ui_story"]) then
					arg_219_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1016ui_story"]) and arg_219_1.var_.characterEffect1016ui_story then
				arg_219_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.275

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(414091054).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 11 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 11)

				if (11 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 11)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play414091055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 414091055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play414091056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1016ui_story = arg_223_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1016ui_story"].transform.position).z)
				arg_223_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1016ui_story"].transform.localEulerAngles = arg_223_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_223_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1016ui_story"].transform.position).z)
				arg_223_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1016ui_story"].transform.localEulerAngles = arg_223_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1016ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1016ui_story == nil then
				arg_223_1.var_.characterEffect1016ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1016ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1016ui_story then
				arg_223_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action7_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.85

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(414091055).content)

				arg_223_1.text_.text = var_226_6

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_8 = 34 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_6) / 34)

				if (34 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_6) / 34)) > 0 and var_226_5 < var_226_8 then
					arg_223_1.talkMaxDuration = var_226_8

					if var_226_8 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_6
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_9 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_9 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_9

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_9 and arg_223_1.time_ < var_226_4 + var_226_9 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play414091056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 414091056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play414091057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1016ui_story"]) and arg_227_1.var_.characterEffect1016ui_story == nil then
				arg_227_1.var_.characterEffect1016ui_story = arg_227_1.actors_["1016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1016ui_story"]) then
				if arg_227_1.var_.characterEffect1016ui_story and not isNil(arg_227_1.actors_["1016ui_story"]) then
					arg_227_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1016ui_story"]) and arg_227_1.var_.characterEffect1016ui_story then
				arg_227_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.425

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(414091056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 17 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 17)

				if (17 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 17)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play414091057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 414091057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play414091058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1035ui_story = arg_231_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1035ui_story"].transform.position).z)
				arg_231_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1035ui_story"].transform.localEulerAngles = arg_231_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.6)
				arg_231_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1035ui_story"].transform.position).z)
				arg_231_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1035ui_story"].transform.localEulerAngles = arg_231_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1035ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1035ui_story == nil then
				arg_231_1.var_.characterEffect1035ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1035ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1035ui_story then
				arg_231_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action483")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_4 = 0
			local var_234_5 = 1

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(414091057).content)

				arg_231_1.text_.text = var_234_6

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_8 = 40 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_6) / 40)

				if (40 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_6) / 40)) > 0 and var_234_5 < var_234_8 then
					arg_231_1.talkMaxDuration = var_234_8

					if var_234_8 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_6
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_9 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_9 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_9

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_9 and arg_231_1.time_ < var_234_4 + var_234_9 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play414091058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 414091058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play414091059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1016ui_story = arg_235_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1016ui_story"].transform.position).z)
				arg_235_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1016ui_story"].transform.localEulerAngles = arg_235_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_235_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1016ui_story"].transform.position).z)
				arg_235_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1016ui_story"].transform.localEulerAngles = arg_235_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1016ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1016ui_story == nil then
				arg_235_1.var_.characterEffect1016ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1016ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1016ui_story then
				arg_235_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action7_2")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_238_4 = arg_235_1.actors_["1035ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1035ui_story == nil then
				arg_235_1.var_.characterEffect1035ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_5 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_5 and not isNil(var_238_4) then
				if arg_235_1.var_.characterEffect1035ui_story and not isNil(var_238_4) then
					arg_235_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_5)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_5 and arg_235_1.time_ < 0 + var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1035ui_story then
				arg_235_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_238_6 = 0
			local var_238_7 = 0.075

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_8 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(414091058).content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_10 = 3 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_8) / 3)

				if (3 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_8) / 3)) > 0 and var_238_7 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_11 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_11 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_11

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_11 and arg_235_1.time_ < var_238_6 + var_238_11 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play414091059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 414091059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play414091060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1035ui_story = arg_239_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1035ui_story"].transform.position).z)
				arg_239_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1035ui_story"].transform.localEulerAngles = arg_239_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.6)
				arg_239_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1035ui_story"].transform.position).z)
				arg_239_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1035ui_story"].transform.localEulerAngles = arg_239_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1035ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1035ui_story == nil then
				arg_239_1.var_.characterEffect1035ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1035ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1035ui_story then
				arg_239_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action434")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_4 = arg_239_1.actors_["1016ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1016ui_story == nil then
				arg_239_1.var_.characterEffect1016ui_story = var_242_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_5 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_5 and not isNil(var_242_4) then
				if arg_239_1.var_.characterEffect1016ui_story and not isNil(var_242_4) then
					arg_239_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_5)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_5 and arg_239_1.time_ < 0 + var_242_5 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1016ui_story then
				arg_239_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_242_6 = 0
			local var_242_7 = 0.375

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(414091059).content)

				arg_239_1.text_.text = var_242_8

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_10 = 15 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_8) / 15)

				if (15 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_8) / 15)) > 0 and var_242_7 < var_242_10 then
					arg_239_1.talkMaxDuration = var_242_10

					if var_242_10 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_8
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_11 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_11 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_11

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_11 and arg_239_1.time_ < var_242_6 + var_242_11 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play414091060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 414091060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play414091061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1035ui_story = arg_243_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1035ui_story"].transform.position).z)
				arg_243_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1035ui_story"].transform.localEulerAngles = arg_243_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.6)
				arg_243_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1035ui_story"].transform.position).z)
				arg_243_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1035ui_story"].transform.localEulerAngles = arg_243_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1035ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1035ui_story == nil then
				arg_243_1.var_.characterEffect1035ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1035ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1035ui_story then
				arg_243_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_4 = 0
			local var_246_5 = 0.825

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(414091060).content)

				arg_243_1.text_.text = var_246_6

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_8 = 33 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_6) / 33)

				if (33 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_6) / 33)) > 0 and var_246_5 < var_246_8 then
					arg_243_1.talkMaxDuration = var_246_8

					if var_246_8 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_6
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_9 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_9 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_9

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_9 and arg_243_1.time_ < var_246_4 + var_246_9 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play414091061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 414091061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play414091062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1016ui_story = arg_247_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1016ui_story"].transform.position).z)
				arg_247_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1016ui_story"].transform.localEulerAngles = arg_247_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_247_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1016ui_story"].transform.position).z)
				arg_247_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1016ui_story"].transform.localEulerAngles = arg_247_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1016ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1016ui_story == nil then
				arg_247_1.var_.characterEffect1016ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1016ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1016ui_story then
				arg_247_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action6_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_250_4 = arg_247_1.actors_["1035ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1035ui_story == nil then
				arg_247_1.var_.characterEffect1035ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_5 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 and not isNil(var_250_4) then
				if arg_247_1.var_.characterEffect1035ui_story and not isNil(var_250_4) then
					arg_247_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_5)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1035ui_story then
				arg_247_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_250_6 = 0
			local var_250_7 = 0.2

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_8 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(414091061).content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 8 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_8) / 8)

				if (8 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_8) / 8)) > 0 and var_250_7 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_11 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_11 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_11

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_11 and arg_247_1.time_ < var_250_6 + var_250_11 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play414091062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 414091062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play414091063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.95

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(414091062).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 38 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 38)

				if (38 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 38)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play414091063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 414091063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play414091064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1016ui_story"]) and arg_255_1.var_.characterEffect1016ui_story == nil then
				arg_255_1.var_.characterEffect1016ui_story = arg_255_1.actors_["1016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1016ui_story"]) then
				if arg_255_1.var_.characterEffect1016ui_story and not isNil(arg_255_1.actors_["1016ui_story"]) then
					arg_255_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1016ui_story"]) and arg_255_1.var_.characterEffect1016ui_story then
				arg_255_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.15

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(414091063).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 6 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 6)

				if (6 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 6)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play414091064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 414091064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play414091065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1016ui_story = arg_259_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1016ui_story"].transform.position).z)
				arg_259_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1016ui_story"].transform.localEulerAngles = arg_259_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_259_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1016ui_story"].transform.position).z)
				arg_259_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1016ui_story"].transform.localEulerAngles = arg_259_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1016ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1016ui_story == nil then
				arg_259_1.var_.characterEffect1016ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1016ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1016ui_story then
				arg_259_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action6_2")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_4 = 0
			local var_262_5 = 0.65

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(414091064).content)

				arg_259_1.text_.text = var_262_6

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_8 = 26 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_6) / 26)

				if (26 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_6) / 26)) > 0 and var_262_5 < var_262_8 then
					arg_259_1.talkMaxDuration = var_262_8

					if var_262_8 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_6
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_9 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_9 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_9

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_9 and arg_259_1.time_ < var_262_4 + var_262_9 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play414091065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 414091065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play414091066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1016ui_story = arg_263_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1016ui_story"].transform.position).z)
				arg_263_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1016ui_story"].transform.localEulerAngles = arg_263_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1016ui_story"].transform.position).z)
				arg_263_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1016ui_story"].transform.localEulerAngles = arg_263_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1035ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1035ui_story = var_266_1.localPosition
			end

			local var_266_2 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 then
				var_266_1.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_2)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 then
				var_266_1.localPosition = Vector3.New(0, 100, 0)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			local var_266_3 = 0
			local var_266_4 = 0.55

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_5 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(414091065).content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 22 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 22)

				if (22 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 22)) > 0 and var_266_4 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_3
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_4, arg_263_1.talkMaxDuration)

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_3) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_3 + var_266_8 and arg_263_1.time_ < var_266_3 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play414091066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 414091066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play414091067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.3

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[975].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(414091066).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 12 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 12)

				if (12 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 12)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play414091067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 414091067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play414091068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.575

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[975].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(414091067).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 23 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 23)

				if (23 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 23)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play414091068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 414091068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play414091069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.325

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(414091068).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 13 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 13)

				if (13 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 13)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play414091069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 414091069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play414091070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1035ui_story = arg_279_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1035ui_story"].transform.position).z)
				arg_279_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1035ui_story"].transform.localEulerAngles = arg_279_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.6)
				arg_279_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1035ui_story"].transform.position).z)
				arg_279_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1035ui_story"].transform.localEulerAngles = arg_279_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1035ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1035ui_story == nil then
				arg_279_1.var_.characterEffect1035ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1035ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1035ui_story then
				arg_279_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action1_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_282_4 = 0
			local var_282_5 = 0.7

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(414091069).content)

				arg_279_1.text_.text = var_282_6

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_8 = 28 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_6) / 28)

				if (28 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_6) / 28)) > 0 and var_282_5 < var_282_8 then
					arg_279_1.talkMaxDuration = var_282_8

					if var_282_8 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_6
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_9 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_9 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_9

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_9 and arg_279_1.time_ < var_282_4 + var_282_9 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play414091070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 414091070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play414091071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1016ui_story = arg_283_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1016ui_story"].transform.position).z)
				arg_283_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1016ui_story"].transform.localEulerAngles = arg_283_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_283_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1016ui_story"].transform.position).z)
				arg_283_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1016ui_story"].transform.localEulerAngles = arg_283_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1016ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1016ui_story == nil then
				arg_283_1.var_.characterEffect1016ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1016ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1016ui_story then
				arg_283_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action3_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_4 = arg_283_1.actors_["1035ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1035ui_story == nil then
				arg_283_1.var_.characterEffect1035ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_5 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 and not isNil(var_286_4) then
				if arg_283_1.var_.characterEffect1035ui_story and not isNil(var_286_4) then
					arg_283_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_5)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1035ui_story then
				arg_283_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_286_6 = 0
			local var_286_7 = 0.75

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(414091070).content)

				arg_283_1.text_.text = var_286_8

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 30 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_8) / 30)

				if (30 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_8) / 30)) > 0 and var_286_7 < var_286_10 then
					arg_283_1.talkMaxDuration = var_286_10

					if var_286_10 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_8
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_11 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_11 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_11

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_11 and arg_283_1.time_ < var_286_6 + var_286_11 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play414091071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 414091071
		arg_287_1.duration_ = 7.8

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play414091072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 1.03400000184774 < arg_287_1.time_ and arg_287_1.time_ <= 1.03400000184774 + arg_290_0 then
				local var_290_0 = arg_287_1.bgs_.H07g

				arg_287_1.bgs_.H07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_290_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_1 = var_290_0:GetComponent("SpriteRenderer")

				if var_290_1 and var_290_1.sprite then
					local var_290_2 = 2 * (var_290_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_290_0.transform.localScale = Vector3.New(var_290_2 / var_290_1.sprite.bounds.size.y < var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x and var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x or var_290_2 / var_290_1.sprite.bounds.size.y, var_290_2 / var_290_1.sprite.bounds.size.y < var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x and var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x or var_290_2 / var_290_1.sprite.bounds.size.y, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "H07g" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_3 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_3 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			if arg_287_1.time_ >= var_290_3 + 0.3 and arg_287_1.time_ < var_290_3 + 0.3 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			local var_290_4 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_5 = 1

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_5 then
				local var_290_6 = Color.New(0, 0, 0)

				var_290_6.a = Mathf.Lerp(0, 1, (arg_287_1.time_ - var_290_4) / var_290_5)
				arg_287_1.mask_.color = var_290_6
			end

			if arg_287_1.time_ >= var_290_4 + var_290_5 and arg_287_1.time_ < var_290_4 + var_290_5 + arg_290_0 then
				local var_290_7 = Color.New(0, 0, 0)

				var_290_7.a = 1
				arg_287_1.mask_.color = var_290_7
			end

			local var_290_8 = 1

			if 1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_9 = 2.03400000184774

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_9 then
				local var_290_10 = Color.New(0, 0, 0)

				var_290_10.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - var_290_8) / var_290_9)
				arg_287_1.mask_.color = var_290_10
			end

			if arg_287_1.time_ >= var_290_8 + var_290_9 and arg_287_1.time_ < var_290_8 + var_290_9 + arg_290_0 then
				local var_290_11 = Color.New(0, 0, 0)

				arg_287_1.mask_.enabled = false
				var_290_11.a = 0
				arg_287_1.mask_.color = var_290_11
			end

			local var_290_12 = arg_287_1.actors_["1016ui_story"].transform

			if 1 < arg_287_1.time_ and arg_287_1.time_ <= 1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1016ui_story = var_290_12.localPosition
			end

			local var_290_13 = 0.001

			if 1 <= arg_287_1.time_ and arg_287_1.time_ < 1 + var_290_13 then
				var_290_12.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 1) / var_290_13)
				var_290_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_12.position).x, (manager.ui.mainCamera.transform.position - var_290_12.position).y, (manager.ui.mainCamera.transform.position - var_290_12.position).z)
				var_290_12.localEulerAngles.z = 0
				var_290_12.localEulerAngles.x = 0
				var_290_12.localEulerAngles = var_290_12.localEulerAngles
			end

			if arg_287_1.time_ >= 1 + var_290_13 and arg_287_1.time_ < 1 + var_290_13 + arg_290_0 then
				var_290_12.localPosition = Vector3.New(0, 100, 0)
				var_290_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_12.position).x, (manager.ui.mainCamera.transform.position - var_290_12.position).y, (manager.ui.mainCamera.transform.position - var_290_12.position).z)
				var_290_12.localEulerAngles.z = 0
				var_290_12.localEulerAngles.x = 0
				var_290_12.localEulerAngles = var_290_12.localEulerAngles
			end

			local var_290_14 = arg_287_1.actors_["1035ui_story"].transform

			if 1 < arg_287_1.time_ and arg_287_1.time_ <= 1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1035ui_story = var_290_14.localPosition
			end

			local var_290_15 = 0.001

			if 1 <= arg_287_1.time_ and arg_287_1.time_ < 1 + var_290_15 then
				var_290_14.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 1) / var_290_15)
				var_290_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_14.position).x, (manager.ui.mainCamera.transform.position - var_290_14.position).y, (manager.ui.mainCamera.transform.position - var_290_14.position).z)
				var_290_14.localEulerAngles.z = 0
				var_290_14.localEulerAngles.x = 0
				var_290_14.localEulerAngles = var_290_14.localEulerAngles
			end

			if arg_287_1.time_ >= 1 + var_290_15 and arg_287_1.time_ < 1 + var_290_15 + arg_290_0 then
				var_290_14.localPosition = Vector3.New(0, 100, 0)
				var_290_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_14.position).x, (manager.ui.mainCamera.transform.position - var_290_14.position).y, (manager.ui.mainCamera.transform.position - var_290_14.position).z)
				var_290_14.localEulerAngles.z = 0
				var_290_14.localEulerAngles.x = 0
				var_290_14.localEulerAngles = var_290_14.localEulerAngles
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_16 = 2.8
			local var_290_17 = 0.8

			if 2.8 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_18 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_18:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_19 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(414091071).content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_21 = 32 <= 0 and var_290_17 or var_290_17 * (utf8.len(var_290_19) / 32)

				if (32 <= 0 and var_290_17 or var_290_17 * (utf8.len(var_290_19) / 32)) > 0 and var_290_17 < var_290_21 then
					arg_287_1.talkMaxDuration = var_290_21
					var_290_16 = var_290_16 + 0.3

					if var_290_21 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_21 + var_290_16
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_22 = var_290_16 + 0.3
			local var_290_23 = math.max(var_290_17, arg_287_1.talkMaxDuration)

			if var_290_16 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_22 + var_290_23 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_22) / var_290_23

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_22 + var_290_23 and arg_287_1.time_ < var_290_22 + var_290_23 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play414091072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 414091072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play414091073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.4

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(414091072).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 16 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 16)

				if (16 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 16)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play414091073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 414091073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play414091074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1049ui_story = arg_297_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1049ui_story"].transform.position).z)
				arg_297_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1049ui_story"].transform.localEulerAngles = arg_297_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_297_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1049ui_story"].transform.position).z)
				arg_297_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1049ui_story"].transform.localEulerAngles = arg_297_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1049ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1049ui_story == nil then
				arg_297_1.var_.characterEffect1049ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1049ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1049ui_story then
				arg_297_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action7_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_300_4 = 0
			local var_300_5 = 0.575

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(414091073).content)

				arg_297_1.text_.text = var_300_6

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_8 = 23 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_6) / 23)

				if (23 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_6) / 23)) > 0 and var_300_5 < var_300_8 then
					arg_297_1.talkMaxDuration = var_300_8

					if var_300_8 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_6
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_9 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_9 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_9

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_9 and arg_297_1.time_ < var_300_4 + var_300_9 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play414091074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 414091074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play414091075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.25

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(414091074).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 10 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 10)

				if (10 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 10)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play414091075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 414091075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play414091076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1049ui_story"]) and arg_305_1.var_.characterEffect1049ui_story == nil then
				arg_305_1.var_.characterEffect1049ui_story = arg_305_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1049ui_story"]) then
				if arg_305_1.var_.characterEffect1049ui_story and not isNil(arg_305_1.actors_["1049ui_story"]) then
					arg_305_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1049ui_story"]) and arg_305_1.var_.characterEffect1049ui_story then
				arg_305_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.875

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(414091075).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 35 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 35)

				if (35 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 35)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play414091076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 414091076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play414091077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.6

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(414091076).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 24 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 24)

				if (24 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 24)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play414091077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 414091077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play414091078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1049ui_story = arg_313_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1049ui_story"].transform.position).z)
				arg_313_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1049ui_story"].transform.localEulerAngles = arg_313_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_313_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1049ui_story"].transform.position).z)
				arg_313_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1049ui_story"].transform.localEulerAngles = arg_313_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1049ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1049ui_story == nil then
				arg_313_1.var_.characterEffect1049ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1049ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1049ui_story then
				arg_313_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action7_2")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_4 = 0
			local var_316_5 = 0.25

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(414091077).content)

				arg_313_1.text_.text = var_316_6

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_8 = 10 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_6) / 10)

				if (10 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_6) / 10)) > 0 and var_316_5 < var_316_8 then
					arg_313_1.talkMaxDuration = var_316_8

					if var_316_8 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_6
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_9 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_9 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_9

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_9 and arg_313_1.time_ < var_316_4 + var_316_9 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play414091078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 414091078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play414091079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1049ui_story"]) and arg_317_1.var_.characterEffect1049ui_story == nil then
				arg_317_1.var_.characterEffect1049ui_story = arg_317_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1049ui_story"]) then
				if arg_317_1.var_.characterEffect1049ui_story and not isNil(arg_317_1.actors_["1049ui_story"]) then
					arg_317_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1049ui_story"]) and arg_317_1.var_.characterEffect1049ui_story then
				arg_317_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.875

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(414091078).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 35 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 35)

				if (35 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 35)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play414091079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 414091079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play414091080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.575

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
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

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(414091079).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 23 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 23)

				if (23 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 23)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play414091080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 414091080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play414091081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1049ui_story = arg_325_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1049ui_story"].transform.position).z)
				arg_325_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1049ui_story"].transform.localEulerAngles = arg_325_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_325_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1049ui_story"].transform.position).z)
				arg_325_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1049ui_story"].transform.localEulerAngles = arg_325_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1049ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1049ui_story == nil then
				arg_325_1.var_.characterEffect1049ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1049ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1049ui_story then
				arg_325_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_328_4 = 0
			local var_328_5 = 0.5

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(414091080).content)

				arg_325_1.text_.text = var_328_6

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_8 = 20 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_6) / 20)

				if (20 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_6) / 20)) > 0 and var_328_5 < var_328_8 then
					arg_325_1.talkMaxDuration = var_328_8

					if var_328_8 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_6
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_9 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_9 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_9

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_9 and arg_325_1.time_ < var_328_4 + var_328_9 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play414091081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 414091081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
			arg_329_1.auto_ = false
		end

		function arg_329_1.playNext_(arg_331_0)
			arg_329_1.onStoryFinished_()
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1049ui_story"]) and arg_329_1.var_.characterEffect1049ui_story == nil then
				arg_329_1.var_.characterEffect1049ui_story = arg_329_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1049ui_story"]) then
				if arg_329_1.var_.characterEffect1049ui_story and not isNil(arg_329_1.actors_["1049ui_story"]) then
					arg_329_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1049ui_story"]) and arg_329_1.var_.characterEffect1049ui_story then
				arg_329_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 1.175

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

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(414091081).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 47 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 47)

				if (47 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 47)) > 0 and var_332_2 < var_332_5 then
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
	Play414091034 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 414091034
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play414091035(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1049ui_story"]) and arg_333_1.var_.characterEffect1049ui_story == nil then
				arg_333_1.var_.characterEffect1049ui_story = arg_333_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1049ui_story"]) then
				if arg_333_1.var_.characterEffect1049ui_story and not isNil(arg_333_1.actors_["1049ui_story"]) then
					arg_333_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1049ui_story"]) and arg_333_1.var_.characterEffect1049ui_story then
				arg_333_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_336_2 = 0
			local var_336_3 = 0.175

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_4 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(414091034).content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_6 = 7 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_4) / 7)

				if (7 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_4) / 7)) > 0 and var_336_3 < var_336_6 then
					arg_333_1.talkMaxDuration = var_336_6

					if var_336_6 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_7 and arg_333_1.time_ < var_336_2 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play414091035 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 414091035
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play414091036(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1049ui_story"]) and arg_337_1.var_.characterEffect1049ui_story == nil then
				arg_337_1.var_.characterEffect1049ui_story = arg_337_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1049ui_story"]) then
				if arg_337_1.var_.characterEffect1049ui_story and not isNil(arg_337_1.actors_["1049ui_story"]) then
					arg_337_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1049ui_story"]) and arg_337_1.var_.characterEffect1049ui_story then
				arg_337_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.525

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

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(414091035).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 21 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 21)

				if (21 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 21)) > 0 and var_340_2 < var_340_5 then
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
	assets = {
		"TextureConfig/Background/H07f",
		"TextureConfig/Background/ST0101",
		"TextureConfig/Background/H07h",
		"TextureConfig/Background/H07g"
	},
	voices = {}
}
